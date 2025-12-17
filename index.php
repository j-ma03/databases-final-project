<?php
include 'DBproject.php'; 

$available_queries = [
    'q1' => [
        'label' => 'Q1: What are the number of each subtype of common theft in the month with the highest rated DB episode?',
        'sql' => "
            SELECT reportedcrime.year, reportedcrime.month, mode, type, subtype, sum(crimecount) as \"number reported\" 
            FROM reportedcrime
            INNER JOIN (
                SELECT year, month FROM dragonballratings
                ORDER BY rating DESC
                LIMIT 1
            ) highest_rated_month ON reportedcrime.year = highest_rated_month.year AND reportedcrime.month = highest_rated_month.month
            WHERE reportedcrime.mode = 'COMMON THEFT'
            GROUP BY reportedcrime.year, reportedcrime.month, mode, type, subtype
        "
    ],
    'q2' => [
        'label' => 'Q2: What are the number of each subtype of common theft in the month with the lowest rated DB episode?',
        'sql' => "
            SELECT reportedcrime.year, reportedcrime.month, mode, type, subtype, sum(crimecount) as \"number reported\" 
            FROM reportedcrime
            INNER JOIN (
                SELECT year, month FROM dragonballratings
                ORDER BY rating ASC
                LIMIT 1
            ) lowest_rated_month ON reportedcrime.year = lowest_rated_month.year AND reportedcrime.month = lowest_rated_month.month
            WHERE reportedcrime.mode = 'COMMON THEFT'
            GROUP BY reportedcrime.year, reportedcrime.month, mode, type, subtype
        "
    ],
    'q3' => [
        'label' => 'Q3: What was the average episode rating in the month with the lowest number of reported common thefts?',
        'sql' => "
            SELECT year, month, AVG(rating) AS \"average rating\" FROM dragonballratings
            WHERE year = (
                SELECT year FROM (
                    SELECT db.year, db.month, common_theft.total_count FROM dragonballratings db
                    INNER JOIN (
                        SELECT reportedcrime.year, reportedcrime.month, SUM(crimecount) AS total_count FROM reportedcrime
                        WHERE reportedcrime.mode = 'COMMON THEFT'
                        GROUP BY reportedcrime.year, reportedcrime.month
                        ORDER BY total_count ASC LIMIT 1
                    ) common_theft ON db.year = common_theft.year AND db.month = common_theft.month
                    LIMIT 1
                ) lowest_year_month
            )
            AND month = (
                SELECT month FROM (
                    SELECT db.year, db.month, common_theft.total_count FROM dragonballratings db
                    INNER JOIN (
                        SELECT reportedcrime.year, reportedcrime.month, SUM(crimecount) AS total_count FROM reportedcrime
                        WHERE reportedcrime.mode = 'COMMON THEFT'
                        GROUP BY reportedcrime.year, reportedcrime.month
                        ORDER BY total_count ASC LIMIT 1
                    ) common_theft ON db.year = common_theft.year AND db.month = common_theft.month
                    LIMIT 1
                ) lowest_year_month
            )
            GROUP BY year, month
        "
    ],
    'q4' => [
        'label' => 'Q4: For each month from 1997 - 2003, list the number of reported common thefts.',
        'sql' => "
            SELECT year, month, SUM(crimecount) AS \"number reported\" FROM reportedcrime
            WHERE mode = 'COMMON THEFT' AND year >= 1997 AND year <= 2003
            GROUP BY year, month
            ORDER BY year ASC, month ASC
        "
    ],
    'q5' => [
        'label' => 'Q5: For each month from 1997 - 2003, list the average episode rating.',
        'sql' => "
            SELECT year, month, AVG(rating) AS \"average rating\" FROM dragonballratings
            WHERE year >= 1995 
            GROUP BY year, month
            ORDER BY year ASC, month ASC
        "
    ],
    'q6' => [
        'label' => 'Q6: How many episodes were released in the month with the lowest number of reported common thefts?',
        'sql' => "
            SELECT COUNT(*) AS \"number of episodes\" FROM dragonballratings
            WHERE year = (
                SELECT year FROM (
                    SELECT db.year, db.month, common_theft.total_count FROM dragonballratings db
                    INNER JOIN (
                        SELECT reportedcrime.year, reportedcrime.month, SUM(crimecount) AS total_count FROM reportedcrime
                        WHERE reportedcrime.mode = 'COMMON THEFT'
                        GROUP BY reportedcrime.year, reportedcrime.month
                        ORDER BY total_count ASC LIMIT 1
                    ) common_theft ON db.year = common_theft.year AND db.month = common_theft.month
                    LIMIT 1
                ) lowest_year_month
            )
            AND month = (
                SELECT month FROM (
                    SELECT db.year, db.month, common_theft.total_count FROM dragonballratings db
                    INNER JOIN (
                        SELECT reportedcrime.year, reportedcrime.month, SUM(crimecount) AS total_count FROM reportedcrime
                        WHERE reportedcrime.mode = 'COMMON THEFT'
                        GROUP BY reportedcrime.year, reportedcrime.month
                        ORDER BY total_count ASC LIMIT 1
                    ) common_theft ON db.year = common_theft.year AND db.month = common_theft.month
                    LIMIT 1
                ) lowest_year_month
            )
        "
    ],
    'q7' => [
        'label' => 'Q7: How many episodes were released in the month with the highest number of reported common thefts?',
        'sql' => "
            SELECT COUNT(*) AS \"number of episodes\" FROM dragonballratings
            WHERE year = (
                SELECT year FROM (
                    SELECT db.year, db.month, common_theft.total_count FROM dragonballratings db
                    INNER JOIN (
                        SELECT reportedcrime.year, reportedcrime.month, SUM(crimecount) AS total_count FROM reportedcrime
                        WHERE reportedcrime.mode = 'COMMON THEFT'
                        GROUP BY reportedcrime.year, reportedcrime.month
                        ORDER BY total_count DESC LIMIT 1
                    ) common_theft ON db.year = common_theft.year AND db.month = common_theft.month
                    LIMIT 1
                ) highest_year_month
            )
            AND month = (
                SELECT month FROM (
                    SELECT db.year, db.month, common_theft.total_count FROM dragonballratings db
                    INNER JOIN (
                        SELECT reportedcrime.year, reportedcrime.month, SUM(crimecount) AS total_count FROM reportedcrime
                        WHERE reportedcrime.mode = 'COMMON THEFT'
                        GROUP BY reportedcrime.year, reportedcrime.month
                        ORDER BY total_count DESC LIMIT 1
                    ) common_theft ON db.year = common_theft.year AND db.month = common_theft.month
                    LIMIT 1
                ) highest_year_month
            )
        "
    ],
    'q8' => [
        'label' => 'Q8: For each year from 1997 - 2003, list the unemployment rate.',
        'sql' => "
            SELECT * FROM mexicounemployment
            WHERE year >= 1997 AND year <= 2003
        "
    ],
    'q9' => [
        'label' => 'Q9: For each year from 1997 - 2003, list the GDP in Mexico.',
        'sql' => "
            SELECT * FROM mexicogdp
            WHERE year >= 1997 AND year <= 2003
        "
    ],
    'q10' => [
        'label' => 'Q10: Which year had the highest number of reported common theft crimes, and what was the GDP that year?',
        'sql' => "
            SELECT reportedcrime.year, SUM(crimecount) AS total_crimes, mexicogdp.gdp 
            FROM reportedcrime
            INNER JOIN mexicogdp ON reportedcrime.year = mexicogdp.year
            WHERE mode = 'COMMON THEFT'
            GROUP BY reportedcrime.year, mexicogdp.gdp
            ORDER BY total_crimes DESC LIMIT 1
        "
    ],
    'q11' => [
        'label' => 'Q11: Which year had the highest number of reported common theft crimes, and what was the unemployment rate that year?',
        'sql' => "
            SELECT reportedcrime.year, SUM(crimecount) AS total_crimes, mexicounemployment.unemployment 
            FROM reportedcrime
            INNER JOIN mexicounemployment ON reportedcrime.year = mexicounemployment.year
            WHERE mode = 'COMMON THEFT'
            GROUP BY reportedcrime.year, mexicounemployment.unemployment
            ORDER BY total_crimes DESC LIMIT 1
        "
    ],
    'q12' => [
        'label' => 'Q12: Which year had the highest number of reported common theft crimes, and who was president that year?',
        'sql' => "
            SELECT pt.pid, pt.name, pt.start, pt.end, highest_crime.year AS highest_crime_year, highest_crime.total_crimes 
            FROM presidentterms pt
            JOIN (
                SELECT reportedcrime.year, SUM(crimecount) AS total_crimes FROM reportedcrime
                WHERE mode = 'COMMON THEFT'
                GROUP BY reportedcrime.year
                ORDER BY total_crimes DESC LIMIT 1
            ) highest_crime ON pt.start <= highest_crime.year AND pt.end >= highest_crime.year
        "
    ],
    'q13' => [
        'label' => 'Q13: Which year had the highest number of reported crimes, and what was the president\'s approval rating that year?',
        'sql' => "
            SELECT reportedcrime.year, pt.name, par.rating, SUM(reportedcrime.Crimecount) AS TotalCrime
            FROM reportedcrime
            INNER JOIN presidentialapprovalratings AS par ON par.year = reportedcrime.year
            INNER JOIN presidentterms AS pt ON pt.pid = par.pid
            GROUP BY reportedcrime.year, pt.name, par.rating
            ORDER BY TotalCrime DESC
            LIMIT 1
        "
    ],
    'q14' => [
        'label' => 'Q14: Which year had the highest GDP, and what was the number of reported crimes that year?',
        'sql' => "
            SELECT reportedcrime.year, gdp.GDP, SUM(reportedcrime.Crimecount) AS TotalCrime
            FROM reportedcrime
            INNER JOIN mexicogdp AS gdp ON gdp.year = reportedcrime.year
            GROUP BY reportedcrime.year, gdp.GDP
            ORDER BY gdp.GDP DESC
            LIMIT 1
        "
    ],
    'q15' => [
        'label' => 'Q15: What was the most common type of reported crime in the year with the highest GDP?',
        'sql' => "
            SELECT reportedcrime.year, gdp.GDP, reportedcrime.mode, SUM(reportedcrime.CrimeCount) AS CrimeCounts
            FROM reportedcrime
            INNER JOIN mexicogdp AS gdp ON gdp.year = reportedcrime.year
            GROUP BY reportedcrime.year, gdp.GDP, reportedcrime.mode
            ORDER BY gdp.GDP DESC, CrimeCounts DESC
            LIMIT 1
        "
    ],
    'q16' => [
        'label' => 'Q16: What was the most common type of reported crime in the year with the lowest GDP?',
        'sql' => "
            SELECT reportedcrime.year, gdp.GDP, reportedcrime.mode, SUM(reportedcrime.CrimeCount) AS CrimeCounts
            FROM reportedcrime
            INNER JOIN mexicogdp AS gdp ON gdp.year = reportedcrime.year
            GROUP BY reportedcrime.year, gdp.GDP, reportedcrime.mode
            ORDER BY gdp.GDP ASC, CrimeCounts DESC
            LIMIT 1
        "
    ],
    'q17' => [
        'label' => 'Q17: What was the most common type of reported crime in the year with the lowest unemployment?',
        'sql' => "
            SELECT reportedcrime.year, u.unemployment, reportedcrime.mode, SUM(reportedcrime.CrimeCount) AS CrimeCounts
            FROM reportedcrime
            INNER JOIN mexicounemployment AS u ON u.year = reportedcrime.year
            GROUP BY reportedcrime.year, u.unemployment, reportedcrime.mode
            ORDER BY u.unemployment ASC, CrimeCounts DESC
            LIMIT 1
        "
    ],
    'q18' => [
    'label' => 'Q18: What was the most common type of reported crime in the year with the highest unemployment?',
    'sql' => "
        SELECT reportedcrime.year, u.unemployment, reportedcrime.mode, SUM(reportedcrime.CrimeCount) AS CrimeCounts
        FROM reportedcrime
        INNER JOIN mexicounemployment AS u ON u.year = reportedcrime.year
        GROUP BY reportedcrime.year, u.unemployment, reportedcrime.mode
        ORDER BY u.unemployment DESC, CrimeCounts DESC
        LIMIT 1
    "
    ],
    'q19' => [
        'label' => 'Q19: In the month with the lowest rated episode, what was the most common type of crime?',
        'sql' => "
            SELECT dragonballratings.year,
            dragonballratings.month,
            dragonballratings.title,
            dragonballratings.rating,
            subquery.mode,
            subquery.CrimeTotals
            FROM (
                SELECT reportedcrime.year,
                reportedcrime.month,
                reportedcrime.mode,
                SUM(reportedcrime.crimecount) as Crimetotals
                FROM reportedcrime
                GROUP BY reportedcrime.year,
                reportedcrime.month,
                reportedcrime.mode
            ) as subquery
            INNER JOIN dragonballratings on dragonballratings.year = subquery.year
            WHERE dragonballratings.month = subquery.month
            GROUP BY dragonballratings.year,
            dragonballratings.month,
            dragonballratings.title,
            dragonballratings.rating, subquery.mode, subquery.CrimeTotals
            ORDER BY dragonballratings.rating asc, subquery.Crimetotals desc
            LIMIT 1
        "
    ],
];

/**
 * Function to safely output query results as an HTML table.
 * @param mysqli_result $result The result object from the executed query.
 */
function output_results($result) {
    if (!$result || $result->num_rows === 0) {
        echo "<p>No results found.</p>";
        return;
    }

    echo "<table border='1' cellpadding='6' cellspacing='0'>";

    $fields = $result->fetch_fields();
    echo "<tr>";
    foreach ($fields as $field) {
        echo "<th>" . htmlspecialchars($field->name) . "</th>";
    }
    echo "</tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>";
        foreach ($row as $value) {
            echo "<td>" . htmlspecialchars($value) . "</td>";
        }
        echo "</tr>";
    }
    echo "</table>";
}


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $selected_query_id = $_POST['query_option'] ?? '';
    $query_config = $available_queries[$selected_query_id] ?? null;

    if ($query_config) {
        echo "<h2>Results for: " . htmlspecialchars($query_config['label']) . "</h2>";
        $stmt = null; 

        try {
            $sql = $query_config['sql'];
            $stmt = $conn->prepare($sql);

            if ($stmt->execute()) {
                $result = $stmt->get_result();
                
                if ($result) {
                    output_results($result);
                    $result->free();
                } else {
                    echo "<p>Query executed successfully, but no data was returned.</p>";
                }
                
            } else {
                throw new Exception("Error executing query: " . $stmt->error);
            }

        } catch (Exception $e) {
            echo "<p style='color:red;'>Error: " . htmlspecialchars($e->getMessage()) . "</p>";
        } finally {
            if ($stmt) {
                $stmt->close();
            }
            $conn->close(); 
        }
    } else {
        if (!empty($selected_query_id)) { 
            echo "<p style='color:red;'>Invalid query selection.</p>";
        }
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:ital,wght@0,300..900;1,300..900&display=swap" rel="stylesheet">
    <meta charset="UTF-8">
    <title>Dragon Ball & Mexico Query Selector</title>
    <style>
        body { font-family: Figtree, sans-serif; margin: 20px; background: #cfeefc;}
        h1, h3, p, h2, label { color: #672e00ff; }
        form { background: #fff1a2ff; padding: 20px; border-radius: 8px; border: 1px solid #ff8839ff; }
        select, button { padding: 10px; margin-top: 10px; border: 1px solid #ff8839ff; border-radius: 5px; }
        button { background-color: #ffdd1cff; color: #672e00ff; border: none; cursor: pointer; }
        button:hover { background-color: #edb50cff; }
        table { border-collapse: collapse; width: 100%; margin-top: 25px; border-radius: 8px}
        th, td { text-align: left; padding: 12px; border: 1px solid #ff8839ff; background: #ffffffff }
        th { background-color: #ffdd1cff; color: #672e00ff; }
        img {width: 500; height: 250; margin-left: auto; margin-right: auto; display: flex; border-radius: 15px;}
    </style>
</head>
<body>
    <h1> Studying the Relationships Between Dragon Ball and Mexico: Databases Project </h1>
    <h3> Authors: Carly Wang, Jayden Ma </h3>
    <p>Use the drop down to see the possbile query results from the database.</p>
    
    <form method="post" action="">
        <label for="query_option">Choose a Query: </label>
        
        <select id="query_option" name="query_option" required>
            <option value="" disabled selected> Select a Query </option>
            
            <?php
            foreach ($available_queries as $id => $config) {
                echo "<option value='" . htmlspecialchars($id) . "'>" . htmlspecialchars($config['label']) . "</option>";
            }
            ?>
        </select>
        
        <button type="submit"> See Results </button>
    </form>
    
    <hr>
    <img src="goku.jpg"></img>
    
    </body>
</html>