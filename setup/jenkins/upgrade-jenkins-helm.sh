#!/bin/bash

helm upgrade jenkins stable/jenkins -f values.yaml --recreate-pods
