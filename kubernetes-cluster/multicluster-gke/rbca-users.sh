# GET NUMBER OF USERS IN CONTEXT
# GET LENGTH OF AN ARRAY
# GET_NUM_USERS=$(kubectl config get-users | tail -n +2 | wc -w)

#!/bin/bash
# Declare array for get users
echo "-------------------------------------------------------------------------------------------------------------------------"
echo "Grant cluster admin permissions to your user account. You need these permissions 
      to create the necessary role based access control (RBAC) rules for Anthos Service Mesh"
echo "-------------------------------------------------------------------------------------------------------------------------"

declare -a GET_USERS=()
declare -a GET_CONTEXT=()
# GET ALL USERS EXCEPT HEADERS
GET_USERS+=($(kubectl config get-users | tail -n +2)); 
GET_CONTEXT+=($(kubectl config get-contexts --output=name)); 
LENGTH_CLUSTERS=$(echo ${GET_CONTEXT[@]} | wc -w)
echo $LENGTH_CLUSTERS

# FOR EVERY USER CREATE A BINDING CLUSTER 
for (( j=0; j<${LENGTH_CLUSTERS}; j++ ));
do
    # echo ${GET_USERS[$j]}
    kubectl config use-context ${GET_CONTEXT[$j]}
    sleep 1
    kubectl create ns fleet
done

# for each_user_in_cluster in "${GET_USERS[@]}";
# do
#     for each_cluster_context in "${GET_CONTEXT[@]}";
#     do
#         echo $each_cluster_context
#         # $(kubectl config use-context )
#         # $(kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$each_user_in_cluster)
#         sleep 1
#     done
# done

#loop https://www.cyberciti.biz/faq/bash-for-loop-array/
