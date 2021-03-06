#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $5)
    local CP=$(one_line_pem $6)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${PEER}/$2/" \
        -e "s/\${P0PORT}/$3/" \
        -e "s/\${CAPORT}/$4/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $5)
    local CP=$(one_line_pem $6)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${PEER}/$2/" \
        -e "s/\${P0PORT}/$3/" \
        -e "s/\${CAPORT}/$4/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG=$1
PEER=$2
P0PORT=$3
CAPORT=${ORGCAPORT}
PEERPEM=organizations/peerOrganizations/org1.example.com/tlsca/tlsca.org${ORG}.example.com-cert.pem
CAPEM=organizations/peerOrganizations/org1.example.com/ca/ca.org${ORG}.example.com-cert.pem

echo "$(json_ccp $ORG $PEER $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org${ORG}.example.com/connection-peer${PEER}-org${ORG}.json
echo "$(yaml_ccp $ORG $PEER $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org${ORG}.example.com/connection-peer${ORG}-org${ORG}.yaml
