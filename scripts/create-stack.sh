#!/bin/bash

# creates a stack in AWS via CloudFromation

STACKNAME=${1:-Weapon-X-WAF}
NAME=${2:-Example WAF}
METRICNAME=${3:-ExampleWAF}
PRIORITY=${4:-1}
TEMPLATELOCATION=${5:-file://$(pwd)/waf.yml}

VALIDATE="aws cloudformation validate-template --template-body $TEMPLATELOCATION"
echo $VALIDATE
$VALIDATE

CREATE="aws cloudformation create-stack --stack-name $STACKNAME \
                                        --template-body $TEMPLATELOCATION \
                                        --capabilities CAPABILITY_NAMED_IAM \
                                        --parameters ParameterKey=Name,ParameterValue=$NAME \
                                                     ParameterKey=MetricName,ParameterValue=$METRICNAME \
                                                     ParameterKey=Priority,ParameterValue=$PRIORITY \
                                        --tags Key=Project,Value=$PROJECTNAME \
                                               Key=Environment,Value=$ENVIRONMENT \
                                               Key=Creator,Value=$CREATOR"
echo $CREATE
$CREATE
