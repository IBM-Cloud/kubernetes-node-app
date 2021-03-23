#!/bin/bash

set -e
set -o pipefail

function ibmdomain_https() {
    cat yaml-templates/ingress-ibmdomain-template.yaml | \
        MYPROJECT=$MYPROJECT \
        INGRESS_SUBDOMAIN=$INGRESS_SUBDOMAIN \
        INGRESS_SECRET_NAME=$INGRESS_SECRET_NAME \
        KUBERNETES_NAMESPACE=$KUBERNETES_NAMESPACE \
        envsubst > ingress-ibmdomain.yaml
}

function customdomain_http() {
    cat yaml-templates/ingress-customdomain-http-template.yaml | \
        MYPROJECT=$MYPROJECT \
        CUSTOM_SUBDOMAIN=$CUSTOM_SUBDOMAIN \
        KUBERNETES_NAMESPACE=$KUBERNETES_NAMESPACE \
        envsubst > ingress-customdomain-http.yaml
}

function customdomain_https() {
    cat yaml-templates/ingress-customdomain-https-template.yaml | \
    MYPROJECT=$MYPROJECT \
    CUSTOM_SUBDOMAIN=$CUSTOM_SUBDOMAIN \
    INGRESS_SECRET_NAME=$INGRESS_SECRET_NAME \
    KUBERNETES_NAMESPACE=$KUBERNETES_NAMESPACE \
    envsubst > ingress-customdomain-https.yaml
}

function log_error() {
    MSG="Unknown function or something went wrong...."
    printf "%s - [ERROR] %s\n" "$(date)" "$MSG" >&2
}

case "$1" in
    "") ;;
    ibmdomain) "$@"; exit;;
    customdomain_http) "$@"; exit;;
    customdomain_https) "$@"; exit;;
    *) log_error "Unknown function: $1()"; exit 2;;
esac


