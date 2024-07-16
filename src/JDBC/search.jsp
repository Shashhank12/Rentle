<!DOCTYPE html>
<html>
<head>
    <title>Search</title>
</head>
<body>
    <h1>Search Items</h1>
    <form action="results.jsp" method="get">
        <input type="text" name="query" placeholder="Search..."><br>
        <input type="number" name="minPrice" step="0.01" placeholder="Min Price"><br>
        <input type="number" name="maxPrice" step="0.01" placeholder="Max Price"><br>
        <input type="number" name="duration" placeholder="Duration"><br>
        <select name="durationCategory">
            <option value="hours">Hour(s)</option>
            <option value="days">Day(s)</option>
            <option value="week">Week(s)</option>
            <option value="month">Month(s)</option>
        </select>
        <h4>Category</h4>
        <select name="category">
            <option value="all">None</option>
            <option value="tools">Tools</option>
            <option value="electronics">Electronics</option>
            <option value="appliances">Appliances</option>
            <option value="furniture">Furniture</option>
            <option value="cars">Cars</option>
            <option value="suv">SUV</option>
            <option value="trucks">Trucks</option>
        </select>
        <h4>Feature</h4>
        <select name="feature">
            <option value="all">None</option>
            <option value="Four-wheel">Four-wheel</option>
            <option value="electric">Electric</option>
            <option value="tough-terrains">Tough Terrains</option>
            <option value="good-looking">Good-looking</option>
            <option value="auto-pilot">Auto-pilot</option>
        </select>
        <input type="submit" value="Search">
    </form>
</body>
</html>
