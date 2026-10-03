# Teaching template — ADTTE for overall survival and progression-free survival.
# Event and censor definitions must match the SAP word for word.

# library(admiral)
# library(dplyr)

# death_event <- event_source(
#   dataset_name = "adsl",
#   filter = DTHFL == "Y",
#   date = DTHDT,
#   set_values_to = exprs(
#     EVNTDESC = "Death",
#     SRCDOM = "ADSL",
#     SRCVAR = "DTHDT"
#   )
# )

# last_alive <- censor_source(
#   dataset_name = "adsl",
#   date = LSTALVDT,
#   set_values_to = exprs(
#     EVNTDESC = "Alive at last contact",
#     SRCDOM = "ADSL",
#     SRCVAR = "LSTALVDT"
#   )
# )

# pd_event <- event_source(
#   dataset_name = "adrs",
#   filter = PARAMCD == "PD",
#   date = ADT,
#   set_values_to = exprs(
#     EVNTDESC = "Disease progression",
#     SRCDOM = "ADRS",
#     SRCVAR = "ADT"
#   )
# )

# adtte_os <- derive_param_tte(
#   dataset_adsl = adsl,
#   start_date = RANDDT,
#   event_conditions = list(death_event),
#   censor_conditions = list(last_alive),
#   source_datasets = list(adsl = adsl),
#   set_values_to = exprs(PARAMCD = "OS", PARAM = "Overall Survival")
# )

# PFS is a composite: progression or death, with censoring at the last
# adequate assessment when neither has occurred. That last-assessment
# censor is the rule reviewers will look up in the ADRG.

message("Template only. Pre-specify PFS censoring; do not copy OS rules onto PFS.")
