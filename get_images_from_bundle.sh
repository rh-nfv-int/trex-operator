#/bin/bash
blobs=$(opm render quay.io/rh-nfv-int/trex-operator-bundle:v0.2.12 \
| jq -r '.properties[] | select(.type == "olm.bundle.object") | .value.data')
for blob in $blobs
do
	echo "$blob" \
    | base64 --decode \
    | jq -r '.spec.install.spec | select(.deployments != null).deployments[].spec.template.spec.containers[].image'
done