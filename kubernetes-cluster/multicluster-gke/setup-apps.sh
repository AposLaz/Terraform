# kubectl exec --context="${CTX_1}" -n fleet -c sleep \
#     "$(kubectl get pod --context="${CTX_1}" -n fleet -l \
#     app=sleep -o jsonpath='{.items[0].metadata.name}')" \
#     -- /bin/sh -c 'for i in $(seq 1 20); do curl -sS helloworld.fleet:5000/hello; done'

export PROJECT_ID=$(gcloud config get-value project)
export PROJECT_NUMBER=$(gcloud projects describe ${PROJECT_ID} \
    --format="value(projectNumber)")

export CLUSTER_NAME_1="cluster-0"
export CLUSTER_ZONE_1="europe-west3-a"
export CTX_1="gke_${PROJECT_ID}_${CLUSTER_ZONE_1}_${CLUSTER_NAME_1}"

export CLUSTER_NAME_2="cluster-1"
export CLUSTER_ZONE_2="europe-west8-a"
export CTX_2="gke_${PROJECT_ID}_${CLUSTER_ZONE_2}_${CLUSTER_NAME_2}"

export ASM_VERSION="$(./asmcli --version)"
export HELLO_WORLD_DIR=./asm_output/istio-${ASM_VERSION%+*}

echo ""
export ASM_VERSION="$(./asmcli --version)"
export HELLO_WORLD_DIR=./asm_output/istio-${ASM_VERSION%+*}

kubectl create --context=${CTX_1} \
  -f ${HELLO_WORLD_DIR}/samples/helloworld/helloworld.yaml \
  -l version=v1 -n fleet

kubectl create --context=${CTX_2} \
  -f ${HELLO_WORLD_DIR}/samples/helloworld/helloworld.yaml \
  -l version=v2 -n fleet


for CTX in ${CTX_1} ${CTX_2}
do
    kubectl apply --context=${CTX} \
        -f ${HELLO_WORLD_DIR}/samples/sleep/sleep.yaml -n fleet
done

kubectl create --context=${CTX_1} \
    -f ${HELLO_WORLD_DIR}/samples/helloworld/helloworld.yaml \
    -l service=helloworld -n fleet

kubectl create --context=${CTX_2} \
    -f ${HELLO_WORLD_DIR}/samples/helloworld/helloworld.yaml \
    -l service=helloworld -n fleet


kubectl create --context=${CTX_1} \
    -f ${HELLO_WORLD_DIR}/samples/helloworld/helloworld.yaml \
    -l service=helloworld -n fleet

kubectl create --context=${CTX_2} \
    -f ${HELLO_WORLD_DIR}/samples/helloworld/helloworld.yaml \
    -l service=helloworld -n fleet

kubectl exec --context="${CTX_1}" -n fleet -c sleep \
    "$(kubectl get pod --context="${CTX_1}" -n fleet -l \
    app=sleep -o jsonpath='{.items[0].metadata.name}')" \
    -- /bin/sh -c 'for i in $(seq 1 20); do curl -sS helloworld.fleet:5000/hello; done'

kubectl exec --context="${CTX_2}" -n fleet -c sleep \
    "$(kubectl get pod --context="${CTX_2}" -n fleet -l \
    app=sleep -o jsonpath='{.items[0].metadata.name}')" \
    -- /bin/sh -c 'for i in $(seq 1 20); do curl -sS helloworld.fleet:5000/hello; done'

