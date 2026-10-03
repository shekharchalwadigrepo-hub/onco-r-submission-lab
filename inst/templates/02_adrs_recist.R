# Teaching template — oncology response dataset (ADRS), RECIST 1.1 shape.
# admiralonco is the maintained toolbox for this step.
# Confirmation windows and independent-review parameters come from the SAP.

# library(admiral)
# library(admiralonco)
# library(dplyr)

# rs <- read_sdtm("rs")   # overall response, CR/PR/SD/PD/NE
# adsl <- read_adam("adsl")

# adrs <- rs |>
#   filter(RSTESTCD == "OVRLRESP") |>
#   derive_vars_merged(
#     dataset_add = adsl,
#     new_vars = exprs(RANDDT, TRTSDT),
#     by_vars = exprs(STUDYID, USUBJID)
#   )

# Parameter examples a solid-tumor ADRS usually carries:
#   OVR  investigator overall response at each assessment
#   BOR  best overall response
#   CBOR confirmed best overall response
# Separate parameters (not extra columns) when IRC and investigator both exist:
#   OVRIRC, BORIRC

# adrs <- adrs |>
#   derive_param_response(
#     dataset_adsl = adsl,
#     filter_source = PARAMCD == "OVR",
#     source_datasets = list(adrs = adrs),
#     set_values_to = exprs(PARAMCD = "BOR", PARAM = "Best Overall Response")
#   )

message("Template only. Use admiralonco confirmation helpers; do not invent BOR rules.")
