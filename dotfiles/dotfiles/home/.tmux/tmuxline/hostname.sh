#!/usr/bin/env bash

echo "$(hostname | awk '{print toupper(substr($0,1,1))}')"

