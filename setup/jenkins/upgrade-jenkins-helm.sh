#!/bin/bash

helm upgrade capstone-jenkins stable/jenkins -f values.yaml --recreate-pods