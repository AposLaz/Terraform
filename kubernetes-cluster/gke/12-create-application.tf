# ENVIRONMENT VALUES
data "kubectl_filename_list" "manifests_env" {
    pattern = "./applications/blog-microservices/env/*.yaml"
}

resource "kubectl_manifest" "env" {
    count = length(data.kubectl_filename_list.manifests_env.matches)
    yaml_body = file(element(data.kubectl_filename_list.manifests_env.matches, count.index))
}

# KAFKA 
data "kubectl_filename_list" "manifests_kafka" {
    pattern = "./applications/blog-microservices/kafka_topics/*.yaml"
}

resource "kubectl_manifest" "kafka" {
    count = length(data.kubectl_filename_list.manifests_kafka.matches)
    yaml_body = file(element(data.kubectl_filename_list.manifests_kafka.matches, count.index))

    depends_on = [ 
        helm_release.my-kafka
    ]
}

# PVC
data "kubectl_filename_list" "manifests_pvc" {
    pattern = "./applications/blog-microservices/deploy/*.yaml"
}

resource "kubectl_manifest" "pvc" {
    count = length(data.kubectl_filename_list.manifests_pvc.matches)
    yaml_body = file(element(data.kubectl_filename_list.manifests_pvc.matches, count.index))

    depends_on = [ 
        kubectl_manifest.kafka
    ]
}

# DEPLOYMENTS 
data "kubectl_filename_list" "manifests_deploy" {
    pattern = "./applications/blog-microservices/deploy/*.yaml"
}

resource "kubectl_manifest" "deploy" {
    count = length(data.kubectl_filename_list.manifests_deploy.matches)
    yaml_body = file(element(data.kubectl_filename_list.manifests_deploy.matches, count.index))

    depends_on = [ 
        kubectl_manifest.pvc
    ]
}


# SVC 
data "kubectl_filename_list" "manifests_svc" {
    pattern = "./applications/blog-microservices/svc/*.yaml"
}

resource "kubectl_manifest" "svc" {
    count = length(data.kubectl_filename_list.manifests_svc.matches)
    yaml_body = file(element(data.kubectl_filename_list.manifests_svc.matches, count.index))

    depends_on = [ 
        kubectl_manifest.deploy
    ]
}

# INGRESS 
data "kubectl_filename_list" "manifests_ingress" {
    pattern = "./applications/blog-microservices/ingress/*.yaml"
}

resource "kubectl_manifest" "ingress" {
    count = length(data.kubectl_filename_list.manifests_ingress.matches)
    yaml_body = file(element(data.kubectl_filename_list.manifests_ingress.matches, count.index))

    depends_on = [ 
        kubectl_manifest.svc
    ]
}

