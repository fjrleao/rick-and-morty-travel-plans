#!/bin/sh

crystal sam.cr db:create
crystal sam.cr db:migrate
./app