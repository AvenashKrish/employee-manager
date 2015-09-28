/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {

    var counter = 2;

    $("#addButton").click(function() {

        var newTextBoxDiv = $(document.createElement('div'))
                .attr("id", 'TextBoxDiv' + counter);

        newTextBoxDiv.after().html('Task ' + counter + ' - ' +
                '<input type="text" name="task' + counter +
                '" id="textbox' + counter + '" value="" style="width : 200px; " required>');

        newTextBoxDiv.appendTo("#TextBoxesGroup");

        counter++;
    });

    $("#removeButton").click(function() {
        if (counter == 1) {
            alert("No more textbox to remove");
            return false;
        }

        counter--;

        $("#TextBoxDiv" + counter).remove();

    });

    $("#getButtonValue").click(function() {

        var msg = '';
        for (i = 1; i < counter; i++) {
            msg += "\n Textbox #" + i + " : " + $('#textbox' + i).val();
        }
        alert(msg);
    });
    ///
//
//    function loadXMLDoc() {
//        var xmlhttp = new XMLHttpRequest();
//        xmlhttp.onreadystatechange = function() {
//            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
//                myFunction(xmlhttp.responseXML);
//            }
//        }
//        xmlhttp.open("GET", "app.xml", true);
//        xmlhttp.send();
//    }
//    function myFunction(xmlDoc) {
//        var i;
//        var table = "<tr><th>Artist</th><th>Title</th></tr>";
//        var x = xmlDoc.getElementsByTagName("app-name");
//        for (i = 0; i < x.length; i++) {
//            $('#app-name').text(x[i].getElementsByTagName("ARTIST")[0].childNodes[0].nodeValue);
//        }
//        document.getElementById("demo").innerHTML = table;
//    }

    ///
});
