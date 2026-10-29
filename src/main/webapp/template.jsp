<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Templates</title>

<style>
body {
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    background: #f4f6f9;
}

.container { display: flex; }

.sidebar {
    width: 250px;
    background: white;
    padding: 20px;
    border-right: 1px solid #ddd;
    height: 100vh;
}

.sidebar div {
    padding: 10px;
    margin: 5px 0;
    cursor: pointer;
    border-radius: 6px;
}
.sidebar div:hover { background: #eef2ff; }

.main { flex: 1; padding: 20px; }

.search-bar {
    width: 100%;
    padding: 12px;
    border-radius: 8px;
    border: 1px solid #ccc;
    margin-bottom: 20px;
}

.templates {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px,1fr));
    gap: 20px;
}

.card {
    background: white;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    overflow: hidden;
    transition:0.3s;
}
.card:hover { transform: translateY(-5px); }

.card-img-container {
    width: 100%;
    height: 160px; 
    overflow: hidden;
    background: #f0f4f8;
}

.card-img-container img {
    width: 100%;
    height: 100%;
    object-fit: cover; 
    display: block;
}

.previewCanvas {
    display: none; 
}

.card-body { padding: 10px; }

.btn {
    padding: 6px 12px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.use-btn {
    background: #4f7df9;
    color: white;
}
</style>
</head>

<body>

<div class="container">

    <div class="sidebar">
        <h3>Categories</h3>
        <div onclick="filter('all')">All</div>
        <div onclick="filter('brainstorm')">Brainstorm</div>
        <div onclick="filter('planning')">Planning</div>
        <div onclick="filter('design')">Design</div>
    </div>

    <div class="main">
        <input type="text" class="search-bar" placeholder="Search templates..." onkeyup="search(this.value)">

        <h2>Templates</h2>
        
        <div class="templates">

            <div class="card" data-name="kanban" data-cat="planning">
                <div class="card-img-container">
                    <img src="${pageContext.request.contextPath}/images/Gemini_Generated_Image_ey7yh6ey7yh6ey7y.png" alt="Kanban">
                </div>
                <div class="card-body">
                    <h4>Kanban Board</h4>
                    <button class="btn use-btn" onclick="useTemplate('kanban')">Use</button>
                </div>
            </div>

            <div class="card" data-name="mindmap" data-cat="brainstorm">
                <div class="card-img-container">
                    <img src="${pageContext.request.contextPath}/images/Gemini_Generated_Image_yiot86yiot86yiot.png" alt="Mind Map">
                </div>
                <div class="card-body">
                    <h4>Mind Map</h4>
                    <button class="btn use-btn" onclick="useTemplate('mindmap')">Use</button>
                </div>
            </div>

            <div class="card" data-name="flow" data-cat="planning">
                <div class="card-img-container">
                    <img src="${pageContext.request.contextPath}/images/FlowChart.jpeg" alt="Flowchart">
                </div>
                <div class="card-body">
                    <h4>Flowchart</h4>
                    <button class="btn use-btn" onclick="useTemplate('flow')">Use</button>
                </div>
            </div>

            <div class="card" data-name="wireframe" data-cat="design">
                <div class="card-img-container">
                    <img src="${pageContext.request.contextPath}/images/Gemini_Generated_Image_24ao3l24ao3l24ao(1).png" alt="Wireframe">
                </div>
                <div class="card-body">
                    <h4>Wireframe</h4>
                    <button class="btn use-btn" onclick="useTemplate('wireframe')">Use</button>
                </div>
            </div>

            <div class="card" data-name="timeline" data-cat="planning">
                <div class="card-img-container">
                    <img src="${pageContext.request.contextPath}/images/TimeLine.jpeg" alt="Timeline">
                </div>
                <div class="card-body">
                    <h4>Timeline</h4>
                    <button class="btn use-btn" onclick="useTemplate('timeline')">Use</button>
                </div>
            </div>

            <div class="card" data-name="swot" data-cat="planning">
                <div class="card-img-container">
                    <img src="${pageContext.request.contextPath}/images/Gemini_Generated_Image_sn397isn397isn39(1).png" alt="SWOT">
                </div>
                <div class="card-body">
                    <h4>SWOT Analysis</h4>
                    <button class="btn use-btn" onclick="useTemplate('swot')">Use</button>
                </div>
            </div>

        </div> </div> </div> <script>
function useTemplate(type) {
    window.location.href = "${pageContext.request.contextPath}/whiteboard.jsp?template=" + type;
}

function search(val){
    val = val.toLowerCase();
    document.querySelectorAll(".card").forEach(c=>{
        c.style.display = c.dataset.name.includes(val) ? "block" : "none";
    });
}

function filter(cat){
    document.querySelectorAll(".card").forEach(c=>{
        c.style.display = (cat==="all" || c.dataset.cat===cat) ? "block" : "none";
    });
}
</script>

</body>
</html>