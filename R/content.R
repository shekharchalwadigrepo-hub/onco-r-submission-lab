# Teaching content for the Oncology R Submission Lab.
# Educational only. Not FDA guidance and not a validated submission package.

sas_to_r <- data.frame(
  sas_step = c(
    "Study data standards and specs",
    "SDTM tabulations",
    "ADaM analysis datasets",
    "Oncology response and TTE",
    "Sort, merge, derive",
    "Survival analysis",
    "TLFs to RTF / PDF",
    "SAS transport (.xpt)",
    "Variable labels and lengths",
    "define.xml",
    "Reviewer's guide",
    "Program log / environment",
    "Proprietary macro library",
    "Interactive review app"
  ),
  r_counterpart = c(
    "metacore + a locked specification workbook",
    "sdtm.oak / company SDTM scripts; pharmaversesdtm as a pattern",
    "admiral + admiralonco",
    "admiralonco (ADRS, ADTR, ADTTE helpers) + admiral::derive_param_tte()",
    "dplyr, tidyr, admiral derive_* functions",
    "survival, ggsurvfit, cardx / tern (pharmaverse TLGs)",
    "gt, flextable, r2rtf, tfrmt, tern",
    "xportr::xportr_write() wrapping haven",
    "xportr label, type, length, and order checks",
    "defineR or a controlled define.xml build from metacore",
    "ADRG and cSDRG authored to PHUSE templates",
    "logrx + renv lockfile + sessionInfo()",
    "pkglite text bundle, or a .zip where the gateway allows it",
    "Shiny or teal, as in R Consortium Pilot 2"
  ),
  submission_file = c(
    "Specification, not always submitted",
    "m5/.../tabulations/sdtm/*.xpt + define.xml",
    "m5/.../analysis/adam/*.xpt + define.xml",
    "ADRS, ADTR, ADTTE inside the ADaM folder",
    "Programs under analysis/adam/programs",
    "TLF programs; outputs in the CSR appendix or datasets folder per SOP",
    "RTF/PDF displays traced in the ADRG",
    "Required transport for study data unless otherwise agreed",
    "Embedded in XPT; also described in define.xml",
    "Beside the datasets",
    "adrg.pdf and csdrg.pdf",
    "Referenced from the ADRG so a reviewer can reproduce",
    "programs/ or a bundled package the ADRG explains how to restore",
    "Optional; Pilot 2 showed a path, not a requirement"
  ),
  stringsAsFactors = FALSE
)

sdtm_domains <- data.frame(
  domain = c(
    "DM", "DS", "EX", "AE", "CM", "LB", "VS",
    "TU", "TR", "RS", "FA", "PR", "MH", "SV", "SE"
  ),
  name = c(
    "Demographics",
    "Disposition",
    "Exposure",
    "Adverse Events",
    "Concomitant Medications",
    "Laboratory",
    "Vital Signs",
    "Tumor Identification",
    "Tumor Results",
    "Disease Response",
    "Findings About",
    "Procedures",
    "Medical History",
    "Subject Visits",
    "Subject Elements"
  ),
  oncology_role = c(
    "Screening, randomization, death flag often joined later into ADSL",
    "End of treatment and end of study, including progression and death reasons",
    "Study drug administration; dose intensity derivations start here",
    "Safety population analyses; graded with CTCAE",
    "Prior and concomitant anti-cancer therapy",
    "Safety labs; sometimes used in eligibility sensitivity",
    "Baseline covariates and safety",
    "Target, non-target, and new lesions (RECIST identifiers)",
    "Lesion measurements over time; source for tumor shrinkage waterfall",
    "Overall visit response: CR, PR, SD, PD, NE — source for ADRS",
    "Non-standard findings; sometimes used for supplemental response facts",
    "Biopsies, scans, radiotherapy",
    "Baseline disease characteristics when not collected elsewhere",
    "Visit structure for windowing",
    "Element timing that supports ADSL reference dates"
  ),
  stringsAsFactors = FALSE
)

adam_sets <- data.frame(
  dataset = c("ADSL", "ADRS", "ADTR", "ADTTE", "ADAE", "ADCM", "ADLB", "ADTTE supplemental params"),
  structure = c("ADSL", "BDS", "BDS", "BDS (one row per subject per parameter)", "OCCDS", "OCCDS", "BDS", "BDS"),
  purpose = c(
    "One row per subject: population flags, treatment, stratification, reference dates, death",
    "Response parameters: investigator and IRC overall response, best overall response, confirmation",
    "Tumor results at analysis level: target lesion sum, percent change from baseline",
    "Time-to-event: OS, PFS, DOR, TTR with CNSR, ADT, STARTDT, EVNTDESC",
    "Analysis adverse events with treatment-emergent flag and CTCAE grade",
    "Prior / concomitant medications at analysis level",
    "Analysis labs when safety analyses need windowed results",
    "Sensitivity parameters: PFS by IRC vs investigator, next-line censoring variants"
  ),
  typical_sources = c(
    "DM, DS, EX, SV plus randomization extract",
    "RS plus ADSL dates",
    "TR, TU plus ADSL",
    "ADSL, ADRS",
    "AE, ADSL",
    "CM, ADSL",
    "LB, ADSL",
    "ADSL, ADRS"
  ),
  r_entry = c(
    "admiral derive_vars_* chain; company ADSL template",
    "admiralonco::derive_param_response() and confirmation helpers",
    "admiralonco tumor measurement derivations",
    "admiral::derive_param_tte() with event_source() and censor_source()",
    "admiral occurrence dataset helpers",
    "admiral occurrence dataset helpers",
    "admiral BDS parameter derivations",
    "Same TTE pattern with alternate event and censor rules"
  ),
  stringsAsFactors = FALSE
)

endpoints <- data.frame(
  paramcd = c("BOR", "CBOR", "ORR", "PFS", "OS", "DOR", "TTR", "DCR"),
  name = c(
    "Best overall response",
    "Confirmed best overall response",
    "Objective response (analysis flag, often on ADSL or a count from ADRS)",
    "Progression-free survival",
    "Overall survival",
    "Duration of response",
    "Time to response",
    "Disease control rate"
  ),
  estimand_note = c(
    "Best RS strength on or after baseline, before specified intercurrent events",
    "CR/PR confirmed at a later visit per protocol (often >= 4 weeks)",
    "Proportion with confirmed CR or PR; analysis set is usually response-evaluable",
    "Time from randomization to progression or death; censor rules must be pre-specified",
    "Time from randomization to death; living subjects censored at last known alive",
    "Time from first response to progression or death, responders only",
    "Time from randomization to first response, responders only",
    "CR + PR + SD for a protocol-defined minimum duration"
  ),
  where_it_lives = c(
    "ADRS parameter, AVALC in CR/PR/SD/PD/NE",
    "ADRS parameter",
    "ADSL flag and/or a TLF, not always its own BDS row",
    "ADTTE",
    "ADTTE",
    "ADTTE",
    "ADTTE",
    "ADSL flag or TLF derived from BOR"
  ),
  stringsAsFactors = FALSE
)

package_rows <- data.frame(
  package = c(
    "admiral", "admiralonco", "pharmaverseadam", "pharmaversesdtm",
    "metacore", "metatools", "xportr", "datasetjson",
    "logrx", "pkglite", "renv", "tern", "rtables", "r2rtf",
    "sdtmchecks", "datacutr", "envsetup"
  ),
  job = c(
    "Core ADaM derivations shared across therapeutic areas",
    "Solid-tumor RECIST helpers for ADRS, ADTR, and related dates",
    "Example ADaM data, including oncology ADRS, used only as a pattern",
    "Example SDTM data used only as a pattern",
    "Read a specification into a metadata object",
    "Apply metadata: types, labels, lengths, code lists",
    "Write and check SAS v5 transport files",
    "Write Dataset-JSON, the format exercised in Pilot 5",
    "Program log with messages, warnings, errors, and dependency list",
    "Serialize an R package to plain text for a restrictive gateway",
    "Lock the package library the reviewer is asked to restore",
    "Higher-level clinical TLGs on top of rtables",
    "Table layouts used by pharmaverse TLG packages",
    "RTF output still common in CSR appendices",
    "Conformance-style checks on SDTM",
    "Data cut enforcement before derivations",
    "Standardize program setup (paths, libraries) across a study repo"
  ),
  stringsAsFactors = FALSE
)

checklist <- data.frame(
  area = c(
    rep("Standards", 4),
    rep("Tabulation data", 4),
    rep("Analysis data", 5),
    rep("Displays", 3),
    rep("Traceability", 4),
    rep("Gateway package", 4)
  ),
  item = c(
    "CDISC versions match the FDA Data Standards Catalog entry you are citing",
    "Therapeutic-area conventions (RECIST 1.1 or the protocol criteria) are named in define.xml and ADRG",
    "Analysis sets and estimands match the statistical analysis plan",
    "Data cut date is applied before SDTM freeze and again before ADaM",
    "SDTM XPT files, define.xml, and cSDRG are in the tabulations folder",
    "Annotated CRF is available for reviewer traceability",
    "Oncology RS, TR, and TU are present when response is an endpoint",
    "Controlled terminology versions are stated",
    "ADSL plus endpoint datasets (ADRS, ADTR, ADTTE) trace to SDTM in define.xml Origin",
    "Every analysis population flag used in a TLF exists on ADSL",
    "XPT variable names are <= 8 characters; labels <= 40; no special characters the transport forbids",
    "Programs that create each ADaM are named in the ADRG and submitted",
    "Sensitivity analyses (IRC vs investigator, alternate censoring) are separate parameters, not silent overwrites",
    "TLF programs point at ADaM, not at SDTM, unless the SAP explicitly says otherwise",
    "Outputs in the CSR match the program identifiers in the ADRG",
    "Figures (waterfall, spider, KM) use the same ADRS / ADTTE parameters as the tables",
    "ADRG section 7 (or the PHUSE reproduction section) runs from a clean session",
    "renv.lock or an equivalent manifest is referenced",
    "logrx or the program log is retained with the programs",
    "No absolute paths, credentials, or patient listings beyond what the package allows",
    "Folder names follow the study-data guide: tabulations/sdtm and analysis/adam",
    "File names match define.xml and the reviewer's guides",
    "Proprietary code is either submitted (text bundle or accepted archive) or not required to reproduce",
    "Cover letter states language, R version, and that datasets are XPT (or Dataset-JSON if agreed)"
  ),
  owner = c(
    "Standards lead", "Clinician + programmer", "Statistician", "Data manager",
    "SDTM programmer", "Data manager", "SDTM programmer", "Standards lead",
    "ADaM programmer", "Statistician", "ADaM programmer", "ADaM programmer", "Statistician",
    "TLF programmer", "Medical writer", "TLF programmer",
    "Programming lead", "Programming lead", "Programming lead", "Programming lead",
    "Publishing", "Publishing", "Programming lead", "Regulatory affairs"
  ),
  stringsAsFactors = FALSE
)

pilots <- data.frame(
  pilot = c("Pilot 1", "Pilot 2", "Pilot 3", "Pilot 4", "Pilot 5"),
  what = c(
    "R scripts that generate TLFs, submitted via eCTD",
    "A Shiny application bundled for review",
    "ADaM datasets and TLFs generated in R, with source SDTM",
    "Containers and WebAssembly for Shiny (evaluation)",
    "Same idea as Pilot 3, with Dataset-JSON instead of XPT"
  ),
  takeaway = c(
    "Reviewers could re-run R TLF programs when the ADRG was explicit",
    "An interactive app can be part of a package; it does not replace XPT datasets",
    "admiral-style ADaM programs can sit in the analysis programs folder",
    "Reproducible execution environments are under evaluation, not the default path",
    "Transport format is evolving; do not drop XPT until the catalog and your agreement allow it"
  ),
  stringsAsFactors = FALSE
)

glossary <- data.frame(
  term = c(
    "eCTD", "Module 5", "SDTM", "ADaM", "BDS", "OCCDS", "ADSL",
    "XPT", "define.xml", "cSDRG", "ADRG", "RECIST 1.1", "BOR",
    "PFS", "OS", "CNSR", "Estimand", "Data Standards Catalog"
  ),
  meaning = c(
    "Electronic Common Technical Document, the folder and lifecycle structure FDA receives",
    "Clinical study reports and the study-data folders that sit with them",
    "Study Data Tabulation Model: observed data in a standard shape",
    "Analysis Data Model: analysis-ready data traced back to SDTM",
    "Basic Data Structure: parameters in rows (ADRS, ADTTE, ADLB)",
    "Occurrence Data Structure: one row per event (ADAE, ADCM)",
    "Subject-level analysis dataset, one row per person",
    "SAS Version 5 transport file, the long-standing FDA study-data file",
    "Machine-readable metadata for domains, variables, and origins",
    "Clinical Study Data Reviewer's Guide (SDTM side)",
    "Analysis Data Reviewer's Guide (ADaM and TLF reproduction)",
    "Response criteria for solid tumors: CR, PR, SD, PD, NE, with confirmation rules",
    "Best overall response across on-study assessments",
    "Progression-free survival",
    "Overall survival",
    "Censor flag on ADTTE: 0 = event, 1 = censored",
    "The treatment effect a trial is designed to estimate, including intercurrent events",
    "FDA list of supported standard versions and dates you must align to"
  ),
  stringsAsFactors = FALSE
)

ectd_nodes <- data.frame(
  path = c(
    "m5/",
    "m5/datasets/",
    "m5/datasets/{studyid}/",
    "m5/datasets/{studyid}/tabulations/",
    "m5/datasets/{studyid}/tabulations/sdtm/",
    "m5/datasets/{studyid}/tabulations/sdtm/dm.xpt",
    "m5/datasets/{studyid}/tabulations/sdtm/rs.xpt",
    "m5/datasets/{studyid}/tabulations/sdtm/tr.xpt",
    "m5/datasets/{studyid}/tabulations/sdtm/tu.xpt",
    "m5/datasets/{studyid}/tabulations/sdtm/define.xml",
    "m5/datasets/{studyid}/tabulations/sdtm/csdrg.pdf",
    "m5/datasets/{studyid}/analysis/",
    "m5/datasets/{studyid}/analysis/adam/",
    "m5/datasets/{studyid}/analysis/adam/datasets/",
    "m5/datasets/{studyid}/analysis/adam/datasets/adsl.xpt",
    "m5/datasets/{studyid}/analysis/adam/datasets/adrs.xpt",
    "m5/datasets/{studyid}/analysis/adam/datasets/adtr.xpt",
    "m5/datasets/{studyid}/analysis/adam/datasets/adtte.xpt",
    "m5/datasets/{studyid}/analysis/adam/datasets/define.xml",
    "m5/datasets/{studyid}/analysis/adam/programs/",
    "m5/datasets/{studyid}/analysis/adam/programs/adsl.r",
    "m5/datasets/{studyid}/analysis/adam/programs/adrs.r",
    "m5/datasets/{studyid}/analysis/adam/programs/adtte.r",
    "m5/datasets/{studyid}/analysis/adam/programs/tlf-orr.r",
    "m5/datasets/{studyid}/analysis/adam/adrg.pdf"
  ),
  kind = c(
    "Module", "Folder", "Study", "Folder", "Folder",
    "Dataset", "Dataset", "Dataset", "Dataset", "Metadata", "Guide",
    "Folder", "Folder", "Folder",
    "Dataset", "Dataset", "Dataset", "Dataset", "Metadata",
    "Folder", "Program", "Program", "Program", "Program", "Guide"
  ),
  stringsAsFactors = FALSE
)
