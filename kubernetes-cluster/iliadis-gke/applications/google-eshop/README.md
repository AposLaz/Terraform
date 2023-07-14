SOS

https://medium.com/google-cloud/online-boutiques-helm-chart-to-simplify-the-setup-of-advanced-scenarios-with-service-mesh-and-246119e46d53

ONLINEBOUTIQUE_NAMESPACE=onlineboutique
helm upgrade onlineboutique oci://us-docker.pkg.dev/online-boutique-ci/charts/onlineboutique \
 --install \
 --create-namespace \
 -n ${ONLINEBOUTIQUE_NAMESPACE}
