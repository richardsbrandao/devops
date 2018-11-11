#!/bin/bash
set -o xtrace

# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html

/etc/eks/bootstrap.sh --apiserver-endpoint '${CLUSTER_ENDPOINT}' \
    --b64-cluster-ca '${CERTIFICATE_AUTHORITY_DATA}' \
    '${CLUSTER_NAME}'