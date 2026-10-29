<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Whiteboard Pro</title>

<style>
body{margin:0;font-family:'Segoe UI';background:#eef2f7;}

.topbar {
    height: 50px;
    background: linear-gradient(90deg, #4a90e2, #2d6cdf);
    color: white;
    display: flex;
    align-items: center;
    justify-content: space-between; /* Pushes content to opposite ends */
    padding: 0 20px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.brand {
    font-size: 18px;
    font-weight: bold;
    letter-spacing: 0.5px;
}

.dash-btn {
    text-decoration: none;
    color: #2d6cdf;      /* Professional blue text */
    font-size: 13px;
    font-weight: 600;
    background: white;   /* White background as seen in your screenshot */
    padding: 6px 14px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    gap: 8px;
    transition: 0.2s all ease;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.dash-btn:hover {
    background: #f8fafc;
    transform: translateY(-1px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
}
.toolbar{
    position:fixed;
    top:50px;
    left:50%;
    transform:translateX(-50%);
    background:white;
    padding:11px;
    border-radius:12px;
    box-shadow:0 6px 20px rgba(0,0,0,0.15);
    display:flex;
    gap:10px;
    z-index:1000;
}

.tool-btn{
    position:relative;
    padding:8px 10px;
    border-radius:8px;
    background:#f4f6fb;
    cursor:pointer;
    transition:0.2s;
}

.tool-btn:hover{
    background:#2d6cdf;
    color:white;
    transform:scale(1.1);
}

.tool-btn::after{
    content:attr(data-tip);
    position:absolute;
    bottom:-25px;
    left:50%;
    transform:translateX(-50%);
    background:black;
    color:white;
    padding:3px 6px;
    font-size:10px;
    border-radius:4px;
    opacity:0;
}
.tool-btn:hover::after{opacity:1;}

.tool-btn span{
    display:block;
    font-size:10px;
    text-align:center;
}

.dropdown{position:relative;}
.dropdown:hover .dropdown-content{display:block;}

.dropdown-content {
    display: none;
    position: absolute;
    top: 100%;
    left: 0;
    background: #fff;
    min-width: 180px;
    border-radius: 12px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    padding: 8px;
    border: 1px solid #e2e8f0;
}

.dropdown-content div {
    display: flex;
    justify-content: space-between; /* Pushes the icon to the right */
    align-items: center;
    padding: 8px 12px;
    font-size: 13px;
    color: #334155;
    border-radius: 6px;
    transition: 0.2s;
}

.dropdown-content div:hover {
    background: #f1f5f9;
    color: #2d6cdf;
}

.dropdown-title {
    font-size: 10px;
    font-weight: 700;
    text-transform: uppercase;
    color: #94a3b8;
    padding: 8px 12px 4px;
    letter-spacing: 0.5px;
}
canvas {
    display: block;
    margin: 20px auto; /* Centers the PDF 'paper' on the screen */
    background: white;
    box-shadow: 0 0 20px rgba(0,0,0,0.2); /* Professional paper shadow */
    max-width: 95%; /* Prevents horizontal overflow */
}

textarea.sticky{
    position:absolute;
    width:180px;
    height:140px;
    background:#fff9a8;
    border:none;
    border-radius:10px;
    padding:10px;
    box-shadow:0 4px 10px rgba(0,0,0,0.2);
    resize:both;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
</head>

<body>

<div class="topbar">
    <span class="brand">🧠 Whiteboard Pro</span>
    
    <a href="dashboard.jsp" class="dash-btn">
        🏠 <span>Dashboard</span>
    </a>
</div>

<div class="toolbar">

<div class="tool-btn" onclick="setTool('pen')">✏<span>Pen</span></div>
<div class="tool-btn" onclick="setTool('eraser')">🧽<span>Eraser</span></div>

<div class="tool-btn dropdown">
⬛<span>Shapes</span>
<div class="dropdown-content">
<div class="dropdown-title">Basic</div>
<div onclick="setTool('rect')">⬛ Rectangle</div>
<div onclick="setTool('circle')">⚪ Circle</div>
<div onclick="setTool('line')">📏 Line</div>
<div onclick="setTool('triangle')">🔺 Triangle</div>
<div onclick="setTool('square')">🟦 Square</div>
<div class="dropdown-title">UML & Diagrams</div>
    <div onclick="setTool('uml-class')">🗂 Class Box</div>
    <div onclick="setTool('uml-actor')">👤 Actor</div>
    <div onclick="setTool('uml-usecase')">⬭ Use Case</div>
    <div onclick="setTool('arrow')">➔ Association</div>
    <div onclick="setTool('diamond')">💠 Decision</div>

    <div class="dropdown-title">Extra Shapes</div>
    <div onclick="setTool('star')">⭐ Star</div>
    <div onclick="setTool('pentagon')">⬠ Pentagon</div>
    <div onclick="setTool('parallelogram')">▱ Data</div>
</div>
</div>

<div class="tool-btn dropdown">
📏<span>Size</span>
<div class="dropdown-content">
<div onclick="setSize(2)">Small</div>
<div onclick="setSize(5)">Medium</div>
<div onclick="setSize(10)">Large</div>
</div>
</div>

<input type="color" id="color" value="#000000">
<input type="color" id="fillColor" value="#ff0000">

<div class="tool-btn" onclick="setTool('text')">🔤<span>Text</span></div>
<div class="tool-btn" onclick="addSticky()">📝<span>Sticky</span></div>

<!-- FULL FONT SIZE RANGE -->
<select id="fontSize">
<option value="8">8</option>
<option value="10">10</option>
<option value="12">12</option>
<option value="14">14</option>
<option value="16">16</option>
<option value="18">18</option>
<option value="20">20</option>
<option value="24">24</option>
<option value="28">28</option>
<option value="32">32</option>
<option value="40">40</option>
<option value="48">48</option>
<option value="64">64</option>
<option value="72">72</option>
</select>

<select id="fontStyle">
<option value="normal">Normal</option>
<option value="bold">Bold</option>
<option value="italic">Italic</option>
</select>

<div class="tool-btn" onclick="undo()">↩<span>Undo</span></div>
<div class="tool-btn" onclick="redo()">↪<span>Redo</span></div>

<div class="tool-btn" onclick="clearBoard()">🧹<span>Clear</span></div>
<div class="tool-btn" onclick="downloadBoard()">💾<span>Save</span></div>

<input type="file" id="fileInput" style="display:none" onchange="loadBoard(event)">
<div class="tool-btn" onclick="fileInput.click()">📂<span>Load</span></div>
<div class="pdf-group" style="display: flex; align-items: center; gap: 8px; margin-left: 10px; padding-left: 10px; border-left: 1px solid #ddd;">
    <input type="file" id="pdfInput" accept="application/pdf" style="display:none" onchange="handlePdfUpload(event)">
    <div class="tool-btn" onclick="document.getElementById('pdfInput').click()">📂<span>Add PDF</span></div>

    <div id="pdf-controls" style="display:none; align-items:center; background:#f8fafc; border:1px solid #cbd5e1; border-radius:20px; padding:4px 12px; gap:10px;">
        <button onclick="changePage(-1)" style="border:none; background:none; cursor:pointer; font-weight:bold; color:#666;">❮</button>
        <span style="font-size:12px; font-family:monospace; font-weight:bold; color:#334155;">
            <span id="page-num">1</span> / <span id="page-count">0</span>
        </span>
        <button onclick="changePage(1)" style="border:none; background:none; cursor:pointer; font-weight:bold; color:#666;">❯</button>
        <div style="width:1px; height:18px; background:#cbd5e1; margin:0 2px;"></div>
        <button onclick="saveAsPdf()" style="background:#10b981; color:white; border:none; border-radius:15px; padding:5px 12px; font-size:11px; cursor:pointer; font-weight:600;">SAVE PDF</button>
    </div>
</div>

</div>

<canvas id="board"></canvas>

<script>
const canvas=document.getElementById("board");
const ctx=canvas.getContext("2d");

canvas.width=window.innerWidth;
canvas.height=window.innerHeight-60;

let tool="pen";
let drawing=false,startX,startY;
let brushSize=3;

let undoStack=[], redoStack=[];

function saveState(){
    undoStack.push(canvas.toDataURL());
    redoStack=[];
}

function undo(){
    if(undoStack.length===0) return;
    redoStack.push(canvas.toDataURL());
    let img=new Image();
    img.src=undoStack.pop();
    img.onload=()=>{ctx.clearRect(0,0,canvas.width,canvas.height);ctx.drawImage(img,0,0);}
}

function redo(){
    if(redoStack.length===0) return;
    undoStack.push(canvas.toDataURL());
    let img=new Image();
    img.src=redoStack.pop();
    img.onload=()=>{ctx.clearRect(0,0,canvas.width,canvas.height);ctx.drawImage(img,0,0);}
}

function setTool(t){tool=t;}
function setSize(s){brushSize=s;}

canvas.onmousedown=e=>{
    // Handle Text Tool
    if(tool==="text"){
        let input=document.createElement("input");
        input.type="text";
        input.style.position="absolute";
        // clientX/Y ensures the box spawns exactly under the mouse pointer
        input.style.left=e.clientX+"px";
        input.style.top=e.clientY+"px";
        input.style.zIndex="2000"; 
        input.style.fontSize=document.getElementById("fontSize").value+"px";
        input.style.border="1px dashed #4a90e2";

        document.body.appendChild(input);
        setTimeout(() => input.focus(), 0);

        input.onblur=()=>{
            if(input.value.trim() !== ""){
                saveState(); // Save undo state only if text was typed
                ctx.font=document.getElementById("fontStyle").value+" "+document.getElementById("fontSize").value+"px Segoe UI";
                ctx.fillStyle=document.getElementById("color").value;
                ctx.fillText(input.value, e.offsetX, e.offsetY);
            }
            document.body.removeChild(input);
        };

        // Allows finishing by pressing Enter
        input.onkeydown=(ev)=>{
            if(ev.key === "Enter") input.blur();
        };

        return; // Stops the pen/drawing logic from starting
    }

    // Handle Drawing (Pen, Shapes, etc)
    saveState();
    drawing=true;
    startX=e.offsetX;
    startY=e.offsetY;
    ctx.beginPath();
    ctx.moveTo(startX,startY);
};
canvas.onmousemove=e=>{
    if(!drawing) return;

    ctx.lineWidth=brushSize;

    if(tool==="pen"){
        ctx.strokeStyle=document.getElementById("color").value;
        ctx.lineTo(e.offsetX,e.offsetY);
        ctx.stroke();
    }

    if(tool==="eraser"){
        ctx.strokeStyle="white";
        ctx.lineTo(e.offsetX,e.offsetY);
        ctx.stroke();
    }
};

canvas.onmouseup = e => {
    if (!drawing) return;
    drawing = false;

    let x = e.offsetX;
    let y = e.offsetY;
    let width = x - startX;
    let height = y - startY;

    ctx.strokeStyle = document.getElementById("color").value;
    ctx.fillStyle = document.getElementById("fillColor").value;
    ctx.lineWidth = brushSize;

    // --- BASIC SHAPES ---
    if (tool === "rect") {
        ctx.fillRect(startX, startY, width, height);
        ctx.strokeRect(startX, startY, width, height);
    }
    if (tool === "square") {
        let side = Math.max(Math.abs(width), Math.abs(height));
        ctx.fillRect(startX, startY, side * Math.sign(width), side * Math.sign(height));
        ctx.strokeRect(startX, startY, side * Math.sign(width), side * Math.sign(height));
    }
    if (tool === "circle") {
        let r = Math.hypot(width, height);
        ctx.beginPath();
        ctx.arc(startX, startY, r, 0, Math.PI * 2);
        ctx.fill();
        ctx.stroke();
    }
    if (tool === "line") {
        ctx.beginPath();
        ctx.moveTo(startX, startY);
        ctx.lineTo(x, y);
        ctx.stroke();
    }
    if (tool === "triangle") {
        ctx.beginPath();
        ctx.moveTo(startX + width / 2, startY);
        ctx.lineTo(startX, y);
        ctx.lineTo(x, y);
        ctx.closePath();
        ctx.fill();
        ctx.stroke();
    }

    // --- UML & DIAGRAMS ---
    if (tool === "uml-class") {
        ctx.fillStyle = "#ffffff"; // Class boxes are usually white
        ctx.fillRect(startX, startY, width, height);
        ctx.strokeRect(startX, startY, width, height);
        ctx.beginPath();
        ctx.moveTo(startX, startY + 25); ctx.lineTo(x, startY + 25); // Header line
        ctx.moveTo(startX, y - (height / 3)); ctx.lineTo(x, y - (height / 3)); // Divider
        ctx.stroke();
    }
    if (tool === "uml-actor") {
        let r = Math.abs(width) / 4;
        ctx.beginPath();
        ctx.arc(startX + width / 2, startY + r, r, 0, Math.PI * 2); // Head
        ctx.moveTo(startX + width / 2, startY + r * 2); ctx.lineTo(startX + width / 2, startY + r * 4); // Body
        ctx.moveTo(startX + width / 2 - r, startY + r * 2.5); ctx.lineTo(startX + width / 2 + r, startY + r * 2.5); // Arms
        ctx.moveTo(startX + width / 2, startY + r * 4); ctx.lineTo(startX, y); // Legs
        ctx.moveTo(startX + width / 2, startY + r * 4); ctx.lineTo(x, y);
        ctx.stroke();
    }
    if (tool === "uml-usecase") {
        ctx.beginPath();
        ctx.ellipse(startX + width / 2, startY + height / 2, Math.abs(width / 2), Math.abs(height / 2), 0, 0, Math.PI * 2);
        ctx.fill();
        ctx.stroke();
    }
    if (tool === "arrow") {
        let headlen = 12;
        let angle = Math.atan2(y - startY, x - startX);
        ctx.beginPath();
        ctx.moveTo(startX, startY);
        ctx.lineTo(x, y);
        ctx.lineTo(x - headlen * Math.cos(angle - Math.PI / 6), y - headlen * Math.sin(angle - Math.PI / 6));
        ctx.moveTo(x, y);
        ctx.lineTo(x - headlen * Math.cos(angle + Math.PI / 6), y - headlen * Math.sin(angle + Math.PI / 6));
        ctx.stroke();
    }

    // --- EXTRA SHAPES ---
    if (tool === "diamond") {
        ctx.beginPath();
        ctx.moveTo(startX + width / 2, startY);
        ctx.lineTo(x, startY + height / 2);
        ctx.lineTo(startX + width / 2, y);
        ctx.lineTo(startX, startY + height / 2);
        ctx.closePath();
        ctx.fill();
        ctx.stroke();
    }
    if (tool === "star") {
        let rot = Math.PI / 2 * 3, step = Math.PI / 5;
        let outer = Math.hypot(width, height), inner = outer / 2.5;
        ctx.beginPath();
        for (let i = 0; i < 5; i++) {
            ctx.lineTo(startX + Math.cos(rot) * outer, startY + Math.sin(rot) * outer);
            rot += step;
            ctx.lineTo(startX + Math.cos(rot) * inner, startY + Math.sin(rot) * inner);
            rot += step;
        }
        ctx.closePath();
        ctx.fill();
        ctx.stroke();
    }
    if (tool === "pentagon") {
        ctx.beginPath();
        for (let i = 0; i < 5; i++) {
            let angle = (i * 2 * Math.PI) / 5 - Math.PI / 2;
            ctx.lineTo(startX + Math.hypot(width, height) * Math.cos(angle), startY + Math.hypot(width, height) * Math.sin(angle));
        }
        ctx.closePath();
        ctx.fill();
        ctx.stroke();
    }
    if (tool === "parallelogram") {
        let skew = width * 0.25;
        ctx.beginPath();
        ctx.moveTo(startX + skew, startY);
        ctx.lineTo(x, startY);
        ctx.lineTo(x - skew, y);
        ctx.lineTo(startX, y);
        ctx.closePath();
        ctx.fill();
        ctx.stroke();
    }
};

function addSticky(){
    let note=document.createElement("textarea");
    note.className="sticky";
    note.style.left="200px";
    note.style.top="200px";
    document.body.appendChild(note);
}

function downloadBoard(){
    const link=document.createElement("a");
    link.href=canvas.toDataURL("image/png");
    link.download="whiteboard.png";
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

function loadBoard(event){
    const file=event.target.files[0];
    if(!file) return;

    const reader=new FileReader();
    reader.onload=e=>{
        let img=new Image();
        img.onload=()=>{
            ctx.clearRect(0,0,canvas.width,canvas.height);
            ctx.drawImage(img,0,0,canvas.width,canvas.height);
        };
        img.src=e.target.result;
    };
    reader.readAsDataURL(file);
}

function clearBoard(){
    ctx.clearRect(0,0,canvas.width,canvas.height);
}
const { jsPDF } = window.jspdf;
pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js';

let pdfDoc = null;
let currentPdfPage = 1;

async function handlePdfUpload(event) {
    const file = event.target.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = async function() {
        const typedarray = new Uint8Array(this.result);
        pdfDoc = await pdfjsLib.getDocument(typedarray).promise;
        document.getElementById('pdf-controls').style.display = 'flex';
        document.getElementById('page-count').textContent = pdfDoc.numPages;
        renderPdfPage(1);
    };
    reader.readAsArrayBuffer(file);
}

async function renderPdfPage(num) {
    const page = await pdfDoc.getPage(num);
    
    // Scale 2.0 = High Definition (Standard for professional apps)
    const viewport = page.getViewport({ scale: 2.0 });
    
    // Forces the canvas to match the high-res PDF dimensions exactly
    canvas.width = viewport.width;
    canvas.height = viewport.height;

    const renderContext = {
        canvasContext: ctx,
        viewport: viewport,
        intent: 'print' // Optimization for clear text rendering
    };

    // Clear board and draw high-quality PDF page
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    await page.render(renderContext).promise;
    
    currentPdfPage = num;
    document.getElementById('page-num').textContent = num;
    
    // Automatically select Pen so you can start annotating the PDF
    setTool('pen'); 
}

function changePage(offset) {
    if (!pdfDoc) return;
    let newPage = currentPdfPage + offset;
    if (newPage >= 1 && newPage <= pdfDoc.numPages) {
        saveState(); 
        renderPdfPage(newPage);
    }
}

function saveAsPdf() {
    const imgData = canvas.toDataURL("image/jpeg", 1.0);
    const pdf = new jsPDF({
        orientation: canvas.width > canvas.height ? 'l' : 'p',
        unit: 'px',
        format: [canvas.width, canvas.height]
    });
    pdf.addImage(imgData, 'JPEG', 0, 0, canvas.width, canvas.height);
    pdf.save("edited_document.pdf");
}
</script>

</body>
</html>