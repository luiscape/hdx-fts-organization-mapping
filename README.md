# Mapping FTS Organization Code to HDX
[OCHA's Financial Tracking Service](http://fts.unocha.org/) asdds unique IDs for each of the organizations on their database. HDX also has a system generated ID. This repository contains the code used to connect to both HDX's and FTS' APIs, compare organizations by name, and try to map their correct codes using a series of approaches (e.g. fuzzy matching, clustering).

The idea is to have the process of matching be as automated as possible.

**Work in progress.**