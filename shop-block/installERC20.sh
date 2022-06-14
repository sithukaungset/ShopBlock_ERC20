#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error
set -e


# launch network; create channel and join peer to channel
pushd ../test-network

# deploy the ERC-20 token contract to the channel
./network.sh deployCC -ccn token_erc20 -ccp ../token-erc-20/chaincode-javascript/ -ccl javascript
popd


# Register identities
# export PATH=${PWD}/../bin:${PWD}
# export FABRIC_CFG_PATH=$PWD/../config/

# Terminal org 1
# export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org1.example.com/

# Register new minter client identity using the fabric-ca-client
# fabric-ca-client register --caname ca-org1 --id.name minter --id.secret minterpw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/org1/tls-cert.pem"

# Generate the identity certificates and MSP folder by providing minter's enroll name and secret
# fabric-ca-client enroll -u https://minter:minterpw@localhost:7054 --caname ca-org1 -M "${PWD}/organizations/peerOrganizations/org1.example.com/users/minter@org1.example.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/org1/tls-cert.pem"

# Copy Node OU configuration file into the minter identity MSP folder
# cp "${PWD}/organizations/peerOrganizations/org1.example.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/org1.example.com/users/minter@org1.example.com/msp/config.yaml"



# Terminal org 2
# export PATH=${PWD}/../bin:${PWD}:$PATH
# export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org2.example.com/

# Register a recipient client identity using fabric-ca-client tool
# fabric-ca-client register --caname ca-org2 --id.name recipient --id.secret recipientpw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/org2/tls-cert.pem"

# Enroll to generate the recipient's identity certificates adn MSP folder
# fabric-ca-client enroll -u https://recipient:recipientpw@localhost:8054 --caname ca-org2 -M "${PWD}/organizations/peerOrganizations/org2.example.com/users/recipient@org2.example.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/org2/tls-cert.pem"

# Copy Node OU configuration file into the recipient identity MSP folder
# cp "${PWD}/organizations/peerOrganizations/org2.example.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/org2.example.com/users/recipient@org2@example.com/msp/config.yaml"

# Initialize the contract in Org1 terminal
# export CORE_PEER_TLS_ENABLED=true
# export CORE_PEER_LOCALMSPID="Org1MSP"
# export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/minter@org1.example.com/msp
# export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
# export CORE_PEER_ADDRESS=localhost:7051
# export TARGET_TLS_OPTIONS= (-0 localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt")


# Initialize the smart contract
# peer chaincode invoke "${TARGET_TLS_OPTIONS[@]}" -C mychannel -n token_erc20 -c '{"function":"SetOption","Args":["some name", "some symbol", "2"]}'

# Mint Token (Back in Org1 terminal) 
# export CORE_PEER_TLS_ENABLED=true
# export CORE_PEER_LOCALMSPID="Org1MSP"
# export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/minter@org1.example.com/msp
# export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
# export CORE_PEER_ADDRESS=localhost:7051
# export TARGET_TLS_OPTIONS=(-o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt")

# Invoke the smart contract to mint 5000 tokens
# peer chaincode invoke "${TARGET_TLS_OPTIONS[@]}" -C mychannel -n token_erc20 -c '{"function":"Mint","Args":["5000"]}'

# Check Client Account Balance
# peer chaincode query -C mychannel -n token_erc20 -c '{"function":"ClientAccountBalance","Args":[]}'

# Transfer Tokens
# Org 2 terminal
# export FABRIC_CFG_PATH=$PWD/../config/
# export CORE_PEER_TLS_ENABLED=true
# export CORE_PEER_LOCALMSPID="Org2MSP"
# export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org2.example.com/users/recipient@org2.example.com/msp
# export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
# export CORE_PEER_ADDRESS=localhost:9051

# Recipient User retrieving own account ID
# peer chaincode query -C mychannel -n token_erc20 -c '{"function":"ClientAccountID","Args":[]}'

# Transfer token from Org1 terminal
# export RECIPIENT="x509::/C=US/ST=North Carolina/O=Hyperledger/OU=client/CN=recipient::/C=UK/ST=Hampshire/L=Hursley/O=org2.example.com/CN=ca.org2.example.com"
# peer chaincode invoke "${TARGET_TLS_OPTIONS[@]}" -C mychannel -n token_erc20 -c '{"function":"Transfer","Args":[ "'"$RECIPIENT"'","100"]}'


cat <<EOF

Total setup execution time : $(($(date +%s) - starttime)) secs ...

Next, use the Shop Block applications to interact with the deployed Shop Block and ERC-20 token contract.
Follow the instructions for the programming language of your choice:

JavaScript:

  Start by changing into the "javascript" directory:
    cd javascript

  Next, install all required packages:
    npm install

  Then run the following applications to enroll the admin user, and register a new user
  called appUser which will be used by the other applications to interact with the deployed
  FabCar contract:
    node enrollAdmin
    node registerUser

  You can run the invoke application as follows. By default, the invoke application will
  create a new car, but you can update the application to submit other transactions:
    node invoke

  You can run the query application as follows. By default, the query application will
  return all cars, but you can update the application to evaluate other transactions:
    node query

TypeScript:

  Start by changing into the "typescript" directory:
    cd typescript

  Next, install all required packages:
    npm install

  Next, compile the TypeScript code into JavaScript:
    npm run build

  Then run the following applications to enroll the admin user, and register a new user
  called appUser which will be used by the other applications to interact with the deployed
  FabCar contract:
    node dist/enrollAdmin
    node dist/registerUser

  You can run the invoke application as follows. By default, the invoke application will
  create a new car, but you can update the application to submit other transactions:
    node dist/invoke

  You can run the query application as follows. By default, the query application will
  return all cars, but you can update the application to evaluate other transactions:
    node dist/query

Java:

  Start by changing into the "java" directory:
    cd java

  Then, install dependencies and run the test using:
    mvn test

  The test will invoke the sample client app which perform the following:
    - Enroll admin and appUser and import them into the wallet (if they don't already exist there)
    - Submit a transaction to create a new car
    - Evaluate a transaction (query) to return details of this car
    - Submit a transaction to change the owner of this car
    - Evaluate a transaction (query) to return the updated details of this car

Go:

  Start by changing into the "go" directory:
    cd go

  Then, install dependencies and run the test using:
    go run fabcar.go

  The test will invoke the sample client app which perform the following:
    - Import user credentials into the wallet (if they don't already exist there)
    - Submit a transaction to create a new car
    - Evaluate a transaction (query) to return details of this car
    - Submit a transaction to change the owner of this car
    - Evaluate a transaction (query) to return the updated details of this car

EOF
