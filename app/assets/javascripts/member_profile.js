$(document).ready(function() {




    $("#owner a.add_fields").
      data("association-insertion-position", 'before').
      data("association-insertion-node", 'this');

    $('#owner').bind('cocoon:after-insert',
         function() {
           $("#owner_from_list").hide();
           $("#owner a.add_fields").hide();
         });
    $('#owner').bind("cocoon:after-remove",
         function() {
           $("#owner_from_list").show();
           $("#owner a.add_fields").show();
         });







    $("#tags a.add_fields").
      data("association-insertion-position", 'before').
      data("association-insertion-node", 'this');

    $('#tags').bind('cocoon:after-insert',
         function(e, tag) {
             console.log('inserting new tag ...');
             $(".project-tag-fields a.add-tag").
                 data("association-insertion-position", 'after').
                 data("association-insertion-node", 'this');
             $(this).find('.project-tag-fields').bind('cocoon:after-insert',
                  function() {
                    console.log('insert new tag ...');
                    console.log($(this));
                    $(this).find(".tag_from_list").remove();
                    $(this).find("a.add_fields").hide();
                  });
         });

    $('.project-tag-fields').bind('cocoon:after-insert',
        function(e) {
            console.log('replace OLD tag ...');
            e.stopPropagation();
            console.log($(this));
            $(this).find(".tag_from_list").remove();
            $(this).find("a.add_fields").hide();
        });






    $('#qualifications').bind('cocoon:before-insert', function(e,qualification_to_be_added) {
        console.log(qualification_to_be_added);
        qualification_to_be_added.fadeIn('slow');
    });

    $('#qualifications').bind('cocoon:after-insert', function(e, added_qualification) {
        //added_task.css("background","red");
    });

    $('#qualifications').bind('cocoon:before-remove', function(e, qualification) {
        $(this).data('remove-timeout', 1000);
        qualification.fadeOut('slow');
    });












    $('#employments').bind('cocoon:before-insert', function(e,employment_to_be_added) {
        console.log(employment_to_be_added);
        employment_to_be_added.fadeIn('slow');
    });

    $('#employments').bind('cocoon:after-insert', function(e, added_employment) {
        //added_task.css("background","red");
    });

    $('#employments').bind('cocoon:before-remove', function(e, employment) {
        $(this).data('remove-timeout', 1000);
        employment.fadeOut('slow');
    });

    //$('body').tabs();
});