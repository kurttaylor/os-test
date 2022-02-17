import numpy as np
np.random.seed(57683) # change this number to one for which your scripts successfully run on the dummy data

from cohortextractor import (
    StudyDefinition,
    patients,
    codelist,
    codelist_from_csv,
    combine_codelists,
)

from codelists import *

study = StudyDefinition(
    default_expectations={
        "date": {"earliest": "1900-01-01", "latest": "today"},
        "rate": "uniform",
        "incidence": 0.5,
    },
    population=patients.registered_with_one_practice_between(
        "2019-02-01", "2020-02-01"
    ),

### AGE ###

    age=patients.age_as_of(
        "2019-09-01",
        return_expectations={
            "rate": "universal",
            "int": {"distribution": "population_ages"},
        },
    ),
    
### SEX ###

    sex=patients.sex(
    return_expectations={
        "rate": "universal",
        "category": {"ratios": {"M": 0.49, "F": 0.51}},
    }
),

### BMI ###

    bmi=patients.most_recent_bmi(
    between=["2010-02-01", "2020-01-31"],
    minimum_age_at_measurement=18,
    include_measurement_date=True,
    date_format="YYYY-MM",
    return_expectations={
        "date": {"earliest": "2010-02-01", "latest": "2020-01-31"},
        "float": {"distribution": "normal", "mean": 28, "stddev": 8},
        "incidence": 0.80,
    }
),

### IMD BASED ON PATIENT ADDRESS

imd=patients.address_as_of(
    "2020-02-29",
    returning="index_of_multiple_deprivation",
    round_to_nearest=100,
    return_expectations={
        "rate": "universal",
        "category": {"ratios": {"100": 0.1, "200": 0.2, "300": 0.7}},
    },
),

####
# COVID TESTS - SGSS
####

first_tested_for_covid=patients.with_test_result_in_sgss(
    pathogen="SARS-CoV-2",
    test_result="any",
    on_or_after="2020-02-01",
    find_first_match_in_period=True,
    returning="date",
    date_format="YYYY-MM-DD",
    return_expectations={
        "date": {"earliest" : "2020-02-01"},
        "rate" : "exponential_increase"
    },
),
first_positive_test_date=patients.with_test_result_in_sgss(
    pathogen="SARS-CoV-2",
    test_result="positive",
    on_or_after="2020-02-01",
    find_first_match_in_period=True,
    returning="date",
    date_format="YYYY-MM-DD",
    return_expectations={
        "date": {"earliest" : "2020-02-01"},
        "rate" : "exponential_increase"
    },
),

####
# COVID-deaths - CPNS
####

died_date_cpns=patients.with_death_recorded_in_cpns(
    on_or_after="2020-02-01",
    returning="date_of_death",
    include_month=True,
    include_day=True,
    return_expectations={
        "date": {"earliest" : "2020-02-01"},
        "rate" : "exponential_increase"
    },
),

####
# SUS
####

ethnicity_6_sus=patients.with_ethnicity_from_sus(
    returning="group_6",
    use_most_frequent_code=True,
    return_expectations={
        "category": {"ratios": {"1": 0.2, "2": 0.2, "3": 0.2, "4": 0.2, "5": 0.2}},
        "incidence": 0.8,
    },
    )

)
