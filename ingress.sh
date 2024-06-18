#!/bin/bash

set -e
set -o pipefail

function ibmsubdomain_https() {
    cat yaml-templates/ingress-ibmsubdomain-template.yaml | \
        MYAPP=$MYAPP \
        INGRESS_SUBDOMAIN=$INGRESS_SUBDOMAIN \
        INGRESS_SECRET_NAME=$INGRESS_SECRET_NAME \
        KUBERNETES_NAMESPACE=$KUBERNETES_NAMESPACE \
        envsubst > ingress-ibmsubdomain.yaml
}

function customdomain_http() {
    cat yaml-templates/ingress-customdomain-http-template.yaml | \
        MYAPP=$MYAPP \
        CUSTOM_SUBDOMAIN=$CUSTOM_SUBDOMAIN \
        KUBERNETES_NAMESPACE=$KUBERNETES_NAMESPACE \
        envsubst > ingress-customdomain-http.yaml
}

function customdomain_https() {
    cat yaml-templates/ingress-customdomain-https-template.yaml | \
    MYAPP=$MYAPP \
    CUSTOM_SUBDOMAIN=$CUSTOM_SUBDOMAIN \
    CUSTOM_SECRET_NAME=$CUSTOM_SECRET_NAME \
    KUBERNETES_NAMESPACE=$KUBERNETES_NAMESPACE \
    envsubst > ingress-customdomain-https.yaml
}

function customdomain_https_sm() {
    cat yaml-templates/ingress-customdomain-https-sm-template.yaml | \
    MYAPP=$MYAPP \
    CUSTOM_SUBDOMAIN=$CUSTOM_SUBDOMAIN \
    CUSTOM_SECRET_NAME=$CUSTOM_SECRET_NAME \
    KUBERNETES_NAMESPACE=$KUBERNETES_NAMESPACE \
    envsubst > ingress-customdomain-https.yaml
}

function log_error() {
    MSG="Unknown function or something went wrong...."
    printf "%s - [ERROR] %s\n" "$(date)" "$MSG" >&2
}

case "$1" in
    "") ;;
    ibmsubdomain_https) "$@"; exit;;
    customdomain_http) "$@"; exit;;
    customdomain_https) "$@"; exit;;
    customdomain_https_sm) "$@"; exit;;
    *) log_error "Unknown function: $1()"; exit 2;;
esac


