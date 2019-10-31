#!/bin/bash

path="${0%/*}"
eksctl create cluster -f "$path"/values.yaml
