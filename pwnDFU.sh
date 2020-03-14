#!/bin/bash

rm -rf ipwndfu_public

git clone https://github.com/LinusHenze/ipwndfu_public.git

cd ipwndfu_public

./ipwndfu -p 

python rmsigchks.py

cd ..


