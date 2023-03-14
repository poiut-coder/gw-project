<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(function() {
		$(document).on('change', '.selectedMonth', function() {
			var todo_no=$(this).data('todo-no');
		//	alert(todo_no);
			

			var selectMonth = $("#selectedMonth"+todo_no).val();//선택한 달 
			var selectYear = $("#selectedYear"+todo_no).val();//선택한 년
			var selectDay = $("#selectedDay"+todo_no).val();//선택한 달 
			$('#selectedDay'+todo_no).empty();// 일 선택자 초기화 


			for (var count = 1; count < 32; count++) {
				if ((selectMonth == 2 && count >= 29)) {//28일까지 

					if ((selectYear % 4 == 0)) {//28일까지
						var option = $("<option value="+count+">" + count + "일"
								+ "</count>")
						$('#selectedDay'+todo_no).append(option);//옵션 새로 붙여넣기 
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
						+ "</count>")
				$('#selectedDay'+todo_no).append(option);//옵션 새로 붙여넣기 
			}
			
			$('#selectedDay'+todo_no).val(selectDay ).prop("selected", true); //
			//datepicker  연동 
			 var x = new Date(selectYear, selectMonth-1, selectDay, 0, 0, 0, 0);
		        $( "#start_date" +todo_no).datepicker( "setDate", x );
		        $( "#s" +todo_no).datepicker( "setDate", x );
		        $( "#start_date_modal").datepicker( "setDate", x );
		        $( "#s_add").datepicker( "setDate", x );

			
			
			
		});
		
		
		
		$(document).on('change', '.selectedYear', function() {
			var todo_no=$(this).data('todo-no');
			//alert(todo_no);
			
			var selectDay = $("#selectedDay"+todo_no).val();//선택한 달
			var selectMonth = $("#selectedMonth"+todo_no).val();//선택한 달 
			var selectYear = $("#selectedYear"+todo_no).val();//선택한 년 
			$('#selectedDay'+todo_no).empty();// 일 선택자 초기화 

			for (var count = 1; count < 32; count++) {
				if ((selectMonth == 2 && count >= 29)) {//28일까지 

					if ((selectYear % 4 == 0)) {//28일까지
						var option = $("<option value="+count+">" + count + "일"
								+ "</count>")
						$('#selectedDay'+todo_no).append(option);//옵션 새로 붙여넣기 
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
						+ "</count>")
				$('#selectedDay'+todo_no).append(option);//옵션 새로 붙여넣기 
			}
			$('#selectedDay'+todo_no).val(selectDay ).prop("selected", true); //

			//datepicker  연동 
			 var x = new Date(selectYear, selectMonth-1, selectDay, 0, 0, 0, 0);
		        $( "#start_date" +todo_no).datepicker( "setDate", x );
		        $( "#s" +todo_no).datepicker( "setDate", x );
		        $( "#start_date_modal").datepicker( "setDate", x );
		        $( "#s_add").datepicker( "setDate", x );

			
			
			
		});
		
		$(document).on('change', '.selectedDay', function() {
			var todo_no=$(this).data('todo-no');
			
			var selectDay = $("#selectedDay"+todo_no).val();//선택한 달
			var selectMonth = $("#selectedMonth"+todo_no).val();//선택한 달 
			var selectYear = $("#selectedYear"+todo_no).val();//선택한 년 
			

			//datepicker  연동 
			 var x = new Date(selectYear, selectMonth-1, selectDay, 0, 0, 0, 0);
  
			$( "#start_date" +todo_no).datepicker( "setDate", x );
	        $( "#s" +todo_no).datepicker( "setDate", x );
	        $( "#start_date_modal").datepicker( "setDate", x );
	        $( "#s_add").datepicker( "setDate", x );

			
			
		});
		
	})
</script>