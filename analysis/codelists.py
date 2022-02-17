from cohortextractor import codelist, codelist_from_csv

asthma_codes = codelist_from_csv(
    "codelists/opensafely-current-asthma.csv",
    system="ctv3",
    column="CTV3ID"
)

aplastic_anaemia_codes = codelist_from_csv(
    "codelists/opensafely-aplastic-anaemia.csv",
    system="ctv3",
    column="CTV3ID"
)