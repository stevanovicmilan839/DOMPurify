<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>DOMPurify 0.7.1 "Excalibur"</title>
        <script src="purify.js"></script>
        <!-- we don't actually need it - just to demo and test the $(html) sanitation -->
        <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
        <script>
            if(typeof console === 'undefined') {console={}; console.log=function(){}}
            window.onload = function(){
                var xhr = new XMLHttpRequest();
                xhr.open('GET', 'https://cdn.rawgit.com/cure53/DOMPurify/master/test/fixtures/expect.js');
                xhr.onload = function(){
                    var data=JSON.parse(xhr.responseText.slice(17, -2));
                    x.value = '<!-- I am ready now, click one of the buttons! -->\r\n';
                    for(i in data) {
                        x.value+=data[i].payload+"\r\n\r\n";
                    }
                }
                xhr.send(null);
            }
        </script>
    </head>
    <body>
        <h4>DOMPurify 0.7.1 "Excalibur"</h4>
        <p>
            <a href="http://badge.fury.io/bo/dompurify"><img style="max-width:100%;" alt="Bower version" src="https://badge.fury.io/bo/dompurify.svg"></a> · <a href="http://badge.fury.io/js/dompurify"><img style="max-width:100%;" alt="npm version" src="https://badge.fury.io/js/dompurify.svg"></a> · <a href="https://travis-ci.org/cure53/DOMPurify"><img style="max-width:100%;" alt="Build Status" src="https://travis-ci.org/cure53/DOMPurify.svg?branch=master"></a>
        </p>
        <p>
        This is the demo for <a href="https://github.com/cure53/DOMPurify">DOMPurify</a>, a DOM-only, super-fast, uber-tolerant XSS sanitizer for HTML, SVG and MathML. 
        The textarea below contains sample-payload - you can also add your own. Watch it sanitize on the console or in the Iframe below.
        </p>
        <hr>
        <button onclick="
            var tx1 = Date.now();
            var xss = DOMPurify.sanitize(x.value);
            console.info('Operation took ' + (t=Date.now()-tx1) + ' milliseconds to complete.');
            console.log(xss);
            y.value=xss;
            timing.innerHTML=t+'ms '+timing.innerHTML
        ">Sanitize textarea value, then write result to console</button>
        <button onclick="
            var ifr = document.getElementById('ifr');
            var tx1 = Date.now();
            var xss = DOMPurify.sanitize(x.value);
            console.info('Operation took ' + (t=Date.now()-tx1) + ' milliseconds to complete.');
            ifr.contentDocument.open();
            ifr.contentDocument.write(xss);
            y.value=xss;
            ifr.contentDocument.close();
            timing.innerHTML=t+'ms '+timing.innerHTML
        ">Sanitize textarea value, then write result to DOM</button>
        <button title="This might not work with the large default payload. Better try with smaller, realistic values" onclick="
            var ifr = document.getElementById('ifr');
            var tx1 = Date.now();
            var xss = DOMPurify.sanitize(x.value, {SAFE_FOR_JQUERY: true});
            console.info('Operation took ' + (t=Date.now()-tx1) + ' milliseconds to complete.');
            $(ifr.contentDocument.body).html(xss);
            y.value=$(ifr.contentDocument.body).html();
            ifr.contentDocument.close();
            timing.innerHTML=t+'ms '+timing.innerHTML
        ">Sanitize textarea value, then use $(elm).html()</button>
        <hr>
        <p>
            Timings: <code id="timing"> </code>
        </p>
        <p><label for="x">Dirty HTML</label></p>
        <textarea placeholder="Payload goes here, test me, test me hard!" id="x" style="width:95%;height:100px"><!-- Loading Test-Vectors ... --></textarea>
        <p><label for="y">Clean HTML</label></p>
        <textarea placeholder="Here be the sanitized markup to inspect!" id="y" style="width:95%;height:100px"></textarea>
        <p><label for="ifr">Clean DOM</label></p>
        <iframe src="about:blank" id="ifr" style="width:95%;height:100px"></iframe>
    </body>
</html>
