#!/usr/bin/env bash

ME=`basename "$0"`

usage()
{
  echo "Usage: $ME" >&2
  exit 1

}

helm package kubebuild
helm package api
helm package kube-launcher
helm package webhooks

helm serve --repo-path ./ &

sleep 1

kill %1

in_file=index.yaml
out_file=index.new.yaml

cat $in_file | sed 's#http://127.0.0.1:8879#https://raw.githubusercontent.com/kubebuild/charts/master#g' > $out_file

mv $out_file $in_file