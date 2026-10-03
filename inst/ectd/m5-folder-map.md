# Module 5 study-data folder map

Educational map aligned to the way FDA study data are organized in an eCTD
submission. Publishing tools may prefix sequences and regional folders.
Confirm the current Study Data Technical Conformance Guide and your
publisher's eCTD specification before a real handoff.

```text
m5/
└── datasets/
    └── {studyid}/
        ├── tabulations/
        │   └── sdtm/
        │       ├── dm.xpt
        │       ├── ds.xpt
        │       ├── ex.xpt
        │       ├── ae.xpt
        │       ├── cm.xpt
        │       ├── rs.xpt          # disease response
        │       ├── tr.xpt          # tumor results
        │       ├── tu.xpt          # tumor identification
        │       ├── define.xml
        │       └── csdrg.pdf
        └── analysis/
            └── adam/
                ├── datasets/
                │   ├── adsl.xpt
                │   ├── adrs.xpt
                │   ├── adtr.xpt
                │   ├── adtte.xpt
                │   ├── adae.xpt
                │   └── define.xml
                ├── programs/
                │   ├── adsl.r
                │   ├── adrs.r
                │   ├── adtr.r
                │   ├── adtte.r
                │   ├── t-orr.r
                │   └── f-km-pfs.r
                └── adrg.pdf
```

Split datasets (`supp--` or split XPT) follow the conformance guide when a
domain exceeds transport limits. Legacy `.xpt` names are lowercase in many
published examples; follow the guide and your define.xml consistently.
