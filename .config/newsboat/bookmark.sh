#!/bin/bash

url="$1"
title="$2"
description="$3"
feed_title="$4"

echo -e "${feed_title}: ${title}\n    ${url}" >> $NOTES
