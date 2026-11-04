SELECT
    *
FROM {{ source('google_sheets', 'stocks_cost_basis') }}