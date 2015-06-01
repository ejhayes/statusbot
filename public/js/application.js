$(document).ready(function() {
  $('.goal-done').click(function(){
    $('#today-goals').append($(this).parent().children().first().text() + '\n');
    $(this).parent().remove();
    return false;
  });

  $('.goal-tomorrow').click(function(){
    $('#tomorrow-goals').append($(this).parent().children().first().text() + '\n');
    $(this).parent().remove();
    return false;
  });

  $('.still-blocker').click(function(){
    $('#blockers').append($(this).parent().children().first().text() + '\n');
    $(this).parent().remove();
    return false;
  });

  $('.blocker-done').click(function(){
    $('#activities').append('B' + $(this).parent().children().first().text() + '\n');
    $(this).parent().remove();
    return false;
  });
});
