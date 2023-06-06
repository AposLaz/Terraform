# resource "helm_release" "istio_base" {
#     name = "my-istio-service-mesh"

#     repository = "https://istio-release.storage.googleapis.com/charts"
#     chart = "base"
#     namespace = "istio-system"
#     create_namespace = true
#     version = "1.17.1"

#     set {
#       name = "global.istioNamespace"
#       value = "istio-system"
#     }

#     depends_on = [ 
#         resource.null_resource.apply_google_eshop
#      ]
# }

# resource "helm_release" "istiod" {
#     name = "my-istiod-service-mesh"
#     repository = "https://istio-release.storage.googleapis.com/charts"
#     chart = "istiod"
#     namespace = "istio-system"
#     create_namespace = true
#     version = "1.17.1"

#     set {
#       name = "telemetry.enabled"
#       value = "value"
#     }

#     set {
#       name = "global.istioNamespace"
#       value = "istio-system"
#     }

#     set {
#       name = "meshConfig.ingressService"
#       value = "istio-gateway"
#     }

#     depends_on = [ 
#         helm_release.istio_base 
#     ]
# }


