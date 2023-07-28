############ HERE DECLARE YOUR CLUSTERS
# RESOURCES 
# 1. https://www.cloudskillsboost.google/focuses/8459?parent=catalog
# 2. https://cloud.google.com/service-mesh/docs/unified-install/gke-install-multi-cluster
# 3. https://cloud.google.com/kubernetes-engine/docs/how-to/multi-cluster-services
# 4. https://cloud.google.com/service-mesh/docs/unified-install/install-dependent-tools

export PROJECT_ID=$(gcloud config get-value project)
export PROJECT_NUMBER=$(gcloud projects describe ${PROJECT_ID} \
    --format="value(projectNumber)")

export CLUSTER_NAME_1="cluster-0"
export CLUSTER_ZONE_1="europe-west3-a"
export CTX_1="gke_${PROJECT_ID}_${CLUSTER_ZONE_1}_${CLUSTER_NAME_1}"

export CLUSTER_NAME_2="cluster-1"
export CLUSTER_ZONE_2="europe-west8-a"
export CTX_1="gke_${PROJECT_ID}_${CLUSTER_ZONE_2}_${CLUSTER_NAME_2}"

export MESH_ID="proj-${PROJECT_NUMBER}"

######################################################### https://www.cloudskillsboost.google/focuses/8459?parent=catalog

echo "**********************************************************************************************************************"
echo "************************************* INSTALL ANTHOS IN EACH CLUSTER *************************************************"
echo "**********************************************************************************************************************"

#wait
sleep 1

gcloud container clusters get-credentials ${CLUSTER_NAME_1} --zone ${CLUSTER_ZONE_1} --project ${PROJECT_ID}
gcloud container clusters get-credentials ${CLUSTER_NAME_2} --zone ${CLUSTER_ZONE_2} --project ${PROJECT_ID}

echo "************************** INSTALL ASMCLI **********************"

curl https://storage.googleapis.com/csm-artifacts/asm/asmcli_1.16 > asmcli
sleep 5
chmod +x asmcli

echo "************************* VALIDATE ASMCLI ************************"

declare -a GET_USERS=()
declare -a GET_CONTEXT=()

# GET ALL USERS EXCEPT HEADERS
export GET_USERS+=($(kubectl config get-users | tail -n +2)); 
export GET_CONTEXT+=($(kubectl config get-contexts --output=name)); 
export LENGTH_CLUSTERS=$(echo ${GET_CONTEXT[@]} | wc -w)
export CLUSTERS_NAME=(${CLUSTER_NAME_1} ${CLUSTER_NAME_2})
export CLUSTERS_ZONE=(${CLUSTER_ZONE_1} ${CLUSTER_ZONE_2})

export GATEWAY_NS=istio-gateway

# FOR EVERY USER CREATE A BINDING CLUSTER 
for (( j=0; j<${LENGTH_CLUSTERS}; j++ ));
do
    # ADD Cluster Labels
    gcloud container clusters update ${CLUSTERS_NAME[$j]} \
        --zone=${CLUSTERS_ZONE[$j]} \
        --update-labels=mesh_id=${MESH_ID}
    # echo ${GET_USERS[$j]}
    kubectl config use-context ${GET_CONTEXT[$j]}
    # create admin role
    kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=${GET_USERS[$j]} 
    # create some namespaces (istio-system is prerequisite)
    kubectl create ns fleet
    kubectl create ns istio-system
    echo "************** INSTALL ASMCLI ***************"
    ./asmcli install \
        --project_id $PROJECT_ID \
        --cluster_name ${CLUSTERS_NAME[$j]} \
        --cluster_location ${CLUSTERS_ZONE[$j]} \
        --fleet_id $PROJECT_ID \
        --output_dir ./asm_output \
        --enable_all \
        --option legacy-default-ingressgateway \
        --ca mesh_ca \
        --enable_gcp_components
    
    echo "************** CREATE ISTIO GATEWAY ***************"
    kubectl create namespace $GATEWAY_NS
    kubectl get deploy -n istio-system -l app=istiod -o jsonpath={.items[*].metadata.labels.'istio\.io\/rev'}'{"\n"}'
    REVISION=$(kubectl get deploy -n istio-system -l app=istiod -o jsonpath={.items[*].metadata.labels.'istio\.io\/rev'}'{"\n"}')
    sleep 2
    kubectl label namespace $GATEWAY_NS istio.io/rev=$REVISION --overwrite
    kubectl label namespace fleet istio.io/rev=$REVISION --overwrite
    kubectl apply -n $GATEWAY_NS -f ./asm_output/samples/gateways/istio-ingressgateway
    kubectl label namespace fleet istio-injection- istio.io/rev=$REVISION --overwrite
    echo "************** SET UP BOOK INFO ***************"
    kubectl apply -f ./asm_output/istio-1.16.7-asm.0/samples/bookinfo/platform/kube/bookinfo.yaml --namespace=fleet
    kubectl apply -f ./asm_output/istio-1.16.7-asm.0/samples/bookinfo/networking/bookinfo-gateway.yaml --namespace=fleet
done

# sleep 2

# function join_by { local IFS="$1"; shift; echo "$*"; }
# ALL_CLUSTER_CIDRS=$(gcloud container clusters list --project $PROJECT_ID --format='value(clusterIpv4Cidr)' | sort | uniq)
# ALL_CLUSTER_CIDRS=$(join_by , $(echo "${ALL_CLUSTER_CIDRS}"))
# ALL_CLUSTER_NETTAGS=$(gcloud compute instances list --project $PROJECT_ID --format='value(tags.items.[0])' | sort | uniq)
# ALL_CLUSTER_NETTAGS=$(join_by , $(echo "${ALL_CLUSTER_NETTAGS}"))

# sleep 1

# gcloud compute firewall-rules create istio-multicluster-pods \
#     --allow=tcp,udp,icmp,esp,ah,sctp \
#     --direction=INGRESS \
#     --priority=900 \
#     --source-ranges="${ALL_CLUSTER_CIDRS}" \
#     --target-tags="${ALL_CLUSTER_NETTAGS}" --quiet \
#     --network=default

# # 
# gcloud projects get-iam-policy $PROJECT_ID \
#     --flatten="bindings[].members" \
#     --filter="bindings.members:user:$(gcloud config get-value core/account 2>/dev/null)"