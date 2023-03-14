<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
    	 
<script type="text/javascript">
	// select 선택자 결정 함
			
		$(function() {
			$(document).on('change', '.selectedcompleteMonth', function() {
				var todo_no=$(this).data('todo-no');
			//	alert(todo_no);
				
				var selectDay = $("#selectedcompleteDay"+todo_no).val();//선택한 달 

				var selectMonth = $("#selectedcompleteMonth"+todo_no).val();//선택한 달 
				var selectYear = $("#selectedcompleteYear"+todo_no).val();//선택한 년 
				$('#selectedcompleteDay'+todo_no).empty();// 일 선택자 초기화 

				for (var count = 1; count < 32; count++) {
					if ((selectMonth == 2 && count >= 29)) {//28일까지 

						if ((selectYear % 4 == 0)) {//28일까지
							var option = $("<option value="+count+">" + count + "일"
									+ "</count>")
							$('#selectedcompleteDay'+todo_no).append(option);//옵션 새로 붙여넣기 
						}
					//	$('#selectedDay').val('test2').prop("selected",true);

						break;
					}
					if ((selectMonth == 2 && count == 29)) {//28일까지 
						break;
					} else if ([ "4", "6", "9", "11" ].includes(selectMonth)
							&& count == 31) {//30일까지 
						break;
					}
					var option = $("<option value="+count+">" + count + "일"
							+ "</option>")
					$('#selectedcompleteDay'+todo_no).append(option);//옵션 새로 붙여넣기 
				}
				
				$('#selectedcompleteDay'+todo_no).val(selectDay ).prop("selected", true); //

				//datepicker  연동 
			      
			        var x = new Date(parseInt(selectYear), parseInt(selectMonth)-1, parseInt(selectDay), 0, 0, 0, 0);
			        $( "#complete_date" +todo_no).datepicker( "setDate", x );
			        $( "#c" +todo_no).datepicker( "setDate", x );
			        $( "#c_add").datepicker( "setDate", x );

				
				
			});
			
			
			
			$(document).on('change', '.selectedcompleteYear', function() {
				var todo_no=$(this).data('todo-no');
				//alert(todo_no);
				
				var selectDay = $("#selectedcompleteDay"+todo_no).val();//선택한 달 

				var selectMonth = $("#selectedcompleteMonth"+todo_no).val();//선택한 달 
				var selectYear = $("#selectedcompleteYear"+todo_no).val();//선택한 년 
				$('#selectedcompleteDay'+todo_no).empty();// 일 선택자 초기화 

				for (var count = 1; count < 32; count++) {
					if ((selectMonth == 2 && count >= 29)) {//28일까지 

						if ((selectYear % 4 == 0)) {//28일까지
							var option = $("<option value="+count+">" + count + "일"
									+ "</option>")
							$('#selectedcompleteDay'+todo_no).append(option);//옵션 새로 붙여넣기 
						}
					//	$('#selectedDay').val('test2').prop("selected",true);

						break;
					}
					if ((selectMonth == 2 && count == 29)) {//28일까지 
						break;
					} else if ([ "4", "6", "9", "11" ].includes(selectMonth)
							&& count == 31) {//30일까지 
						break;
					}
					var option = $("<option value="+count+">" + count + "일"
							+ "</option>")
					$('#selectedcompleteDay'+todo_no).append(option);//옵션 새로 붙여넣기 
				}
				$('#selectedcompleteDay'+todo_no).val(selectDay ).prop("selected", true); //

				
				//datepicker  연동 
				 var x = new Date(parseInt(selectYear), parseInt(selectMonth)-1, parseInt(selectDay), 0, 0, 0, 0);
			        $( "#complete_date" +todo_no).datepicker( "setDate", x );
			       
			        $( "#c" +todo_no).datepicker( "setDate", x );
			        $( "#c_add").datepicker( "setDate", x );

				
				
			});
			
			
			$(document).on('change', '.selectedcompleteDay', function() {
				var todo_no=$(this).data('todo-no');
				//alert(todo_no);
				
				var selectDay = $("#selectedcompleteDay"+todo_no).val();//선택한 달
				var selectMonth = $("#selectedcompleteMonth"+todo_no).val();//선택한 달 
				var selectYear = $("#selectedcompleteYear"+todo_no).val();//선택한 년 
				

				//datepicker  연동 
				 var x = new Date(parseInt(selectYear), parseInt(selectMonth)-1, parseInt(selectDay), 0, 0, 0, 0);
			        $( "#complete_date" +todo_no).datepicker( "setDate", x );
			        $( "#complete_date").datepicker( "setDate", x );

			        $( "#c" +todo_no).datepicker( "setDate", x );

			        $( "#c_add").datepicker( "setDate", x );

				
				
			});
			

		})
	</script>