# project2017-01

## Table of Contents

- [About](#about)
- [Directory Structure](#directory-structure)

## About

**TO-DO:** Write abstract summary

## Directory Structure

The following is not a binding directory structure.
It rather represents an ideal project structure that should help developers navigate with ease.
So, go for it and make some changes changes!

> Consistency within a project is more important. 
> Consistency within one module or function is the most important. 
> ... However, know when to be inconsistent -- sometimes style guide recommendations just aren't applicable. 
> When in doubt, use your best judgment. Look at other examples and decide what looks best. 
> And **don't hesitate to ask!**

[As written in PEP 0008](http://legacy.python.org/dev/peps/pep-0008/)

```
.
├── LICENSE 
├── Makefile                <- Task automation scripts, i.e. 'make data', 'make train'.
├── README.md               <- README for individuals using this project.
├── data
│   ├── external            <- Data from third party sources.
│   ├── intermediate        <- Intermediate data that has been transformed.
│   ├── processed           <- The final, canonical data sets for modeling.
│   └── raw                 <- The original, immutable data dump.
│
├── docs                    <- Project documentation, and logs 
│
├── models                  <- Trained models, model predictions, or model summaries. 
│   │                          Can contain models created through different learning libraries or toolkits such as Weka
│   └── weka                <- Models trained in Weka
│
├── references              <- Data dictionaries, manuals, and all other explanatory materials.
│
├── reports                 <- Gerated anlysis as HTML, PDF, LaTex,etc. (This directory will be used as we transition into Sphynx)
│   └── figures             <- Generated graphics and figures to be used in reporting.
│
├── requirements.txt        <- The requirements file for producing the analysis environment.
│                               
├── src                     <- Source code to use in this project. These could any type of scripts, i.e. MATLAB, Python.
│   ├── data                <- Scripts to download or generate data. 
│   │   └── make_dataset.*  
│   │ 
│   ├── features            <- Scripts to turn raw data into features for modeling, i.e. MATLAB, Python.
│   │   └── build_features.* 
│   │
│   ├── models              <- Scripts to train models and then use trained models to make predictions.
│   │   ├── predict_model.*
│   │   └── train_model.*  
│   │
│   └── visualization       <- Scripts to create exploratory and results oriented visualizations
│       └── visualize.* 
```
