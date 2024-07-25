function handleDrag(obj1, obj2, obj3) {
    var mousedown = false;
    var initialMouseX = 0;
    var initialObj1X = 0;
    var initialObj3Width = 0;

    obj2.addEventListener('mousedown', function(e) {
        e.preventDefault();
        mousedown = true;
        initialMouseX = e.clientX;
        initialObj1X = parseInt(window.getComputedStyle(obj1).left, 10);
        initialObj3Width = parseInt(window.getComputedStyle(obj3).width, 10);
    });

    document.addEventListener('mouseup', function() {
        mousedown = false;
    });
     
    document.addEventListener('mousemove', function(e) {
        if (mousedown) {
            e.preventDefault();
            var diff = e.clientX - initialMouseX;
            obj1.style.left = initialObj1X + diff + 'px';
            obj3.style.width = initialObj3Width - diff + 'px';
        }
    });
}