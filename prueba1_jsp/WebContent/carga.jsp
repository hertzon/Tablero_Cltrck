<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Carga datos base de datos JSP</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="colores.css">
<link rel="stylesheet" type="text/css" href="components.min.css">
	<%@ page import="java.io.IOException" %>
	<%@ page import="java.io.PrintWriter" %>
	<%@ page import="java.sql.Connection" %>
	<%@ page import="java.sql.DriverManager" %>
	<%@ page import="java.sql.ResultSet" %>
	<%@ page import="java.sql.SQLException" %>
	<%@ page import="java.sql.Statement" %>
	<%@ page import="java.io.PrintWriter" %>
</head>
<body>
		<script type="text/javascript">
	<%
		Connection conDB = null;
		Class.forName("org.postgresql.Driver");
		//String url="jdbc:postgresql://localhost:5432/postgres";
		//conDB=DriverManager.getConnection(url,"postgres","irf840");
		String url="jdbc:postgresql://coltrack.com:5432/gpserver";
		conDB=DriverManager.getConnection(url,"ubuntu","xXChPe8Ja8tQQre$");
		Statement st=conDB.createStatement();
// 		String query="SELECT 	date2,\n"
// 				+"coalesce(round(sum(CASE WHEN (q11.event_name = '0' or q11.event_name = '80') THEN q11.accum1 ELSE 0 END)*0.001,2),0) as KMS_GPS,\n"
// 				+"coalesce(round(sum(CASE WHEN (q11.event_name = '0' or q11.event_name = '80') THEN q11.accum7 ELSE 0 END)*1.0/3600,2),0) as DIVING_HOURS,\n"
// 				+"coalesce(round(sum(CASE WHEN (q11.event_name = '0' or q11.event_name = '80') THEN q11.accum8 ELSE 0 END)*1.0/3600,2),0) as IDLE_HOURS,\n"
// 				+"coalesce(SUM(CASE WHEN q11.event_name = '14' THEN 1 ELSE 0 END),0)  As ACCELERATION,\n"
// 				+"coalesce(SUM(CASE WHEN q11.event_name = '15' THEN 1 ELSE 0 END),0)  As BREAKING,\n"
// 				+"coalesce(SUM(CASE WHEN q11.event_name = '8' THEN 1 ELSE 0 END),0)  As IDLING,\n"
// 				+"coalesce(sum(CASE WHEN (q11.event_name = '13' or q11.event_name = '12' or q11.event_name = '11' or q11.event_name = '10' or q11.event_name = '22' or q11.event_name = '17' or q11.event_name = '16') THEN 1 ELSE 0 END),0) As NUM_EXCESOS,\n"
// 				+"coalesce(sum(CASE WHEN (q11.event_name = '13' or q11.event_name = '12' or q11.event_name = '11' or q11.event_name = '10' or q11.event_name = '22' or q11.event_name = '17' or q11.event_name = '16') THEN q11.accum3 ELSE 0 END),0) As DURACION_SEG_TOTAL,\n"
// 				+"coalesce(round(max(CASE WHEN (q11.event_name = '13' or q11.event_name = '12' or q11.event_name = '11' or q11.event_name = '10' or q11.event_name = '22' or q11.event_name = '17' or q11.event_name = '16') THEN q11.accum2 ELSE 0 END)*0.036),0) As MAXIMA_VEL_TOTAL\n"
// 			 +"FROM\n"
// 				+"(SELECT DISTINCT positionreports.unit_id, positionreports.time,positionreports.date2,events.name AS event_name, accumscalamp.accum1,accumscalamp.accum2,accumscalamp.accum3,accumscalamp.accum7,accumscalamp.accum8 FROM positionreports\n"
// 				+"LEFT JOIN events ON positionreports.event_id = events.id\n"
// 				+"LEFT JOIN accumscalamp ON positionreports.accumscalamp_id = accumscalamp.id\n"
// 				+"WHERE\n"
// 				+"positionreports.date2 >= (current_date - interval '1 week')::date::date AND 	--PARAMETER START DATE\n"
// 				+"positionreports.date2 <= current_date::date AND 	--PARAMETER END DATE\n"
// 				+"accumscalamp.date2  >= (current_date - interval '1 week')::date AND\n"
// 				+"accumscalamp.date2 <= current_date::date AND\n"
// 				+"(events.name = '80' or events.name='0' or events.name = '13' or events.name = '12' or events.name='11' or events.name='10' or events.name='22' or events.name='17' or events.name='16'\n"
// 				+"or events.name='14' or events.name='15' or events.name='8') AND\n"
// 				+"positionreports.company_id=109906326) AS q11 --PARAMETER COMPANY\n"
// 				+"GROUP BY date2 ORDER BY date2;";

// 		String query="SELECT 	date2,\n"
// 				+"coalesce(round(sum(CASE WHEN (q11.event_name = '0' or q11.event_name = '80') THEN q11.accum1 ELSE 0 END)*0.001,2),0) as KMS_GPS,\n"
// 				+"coalesce(round(sum(CASE WHEN (q11.event_name = '0' or q11.event_name = '80') THEN q11.accum7 ELSE 0 END)*1.0/3600,2),0) as DIVING_HOURS,\n"
// 				+"coalesce(round(sum(CASE WHEN (q11.event_name = '0' or q11.event_name = '80') THEN q11.accum8 ELSE 0 END)*1.0/3600,2),0) as IDLE_HOURS,\n"
// 				+"coalesce(SUM(CASE WHEN q11.event_name = '14' THEN 1 ELSE 0 END),0)  As ACCELERATION,\n"
// 				+"coalesce(SUM(CASE WHEN q11.event_name = '15' THEN 1 ELSE 0 END),0)  As BREAKING,\n"
// 				+"coalesce(SUM(CASE WHEN q11.event_name = '8' THEN 1 ELSE 0 END),0)  As IDLING,\n"
// 				+"coalesce(sum(CASE WHEN (q11.event_name = '13' or q11.event_name = '12' or q11.event_name = '11' or q11.event_name = '10' or q11.event_name = '22' or q11.event_name = '17' or q11.event_name = '16') THEN 1 ELSE 0 END),0) As NUM_SPEEDING,\n"
// 				+"coalesce(sum(CASE WHEN (q11.event_name = '13' or q11.event_name = '12' or q11.event_name = '11' or q11.event_name = '10' or q11.event_name = '22' or q11.event_name = '17' or q11.event_name = '16') THEN q11.accum3 ELSE 0 END),0) As SPEEDING_SEG_TOTAL,\n"
// 				+"coalesce(round(max(CASE WHEN (q11.event_name = '13' or q11.event_name = '12' or q11.event_name = '11' or q11.event_name = '10' or q11.event_name = '22' or q11.event_name = '17' or q11.event_name = '16') THEN q11.accum2 ELSE 0 END)*0.036),0) As MAX_SPEED_TOTAL,\n"
// 				+"coalesce(sum(CASE WHEN (q11.event_name = '13') THEN 1 ELSE 0 END),0) As NUM_SPEEDING_10,\n"
// 				+"coalesce(sum(CASE WHEN (q11.event_name = '12') THEN 1 ELSE 0 END),0) As NUM_SPEEDING_20,\n"
// 				+"coalesce(sum(CASE WHEN (q11.event_name = '11') THEN 1 ELSE 0 END),0) As NUM_SPEEDING_30,\n"
// 				+"coalesce(sum(CASE WHEN (q11.event_name = '10') THEN 1 ELSE 0 END),0) As NUM_SPEEDING_40,\n"
// 				+"coalesce(sum(CASE WHEN (q11.event_name = '22') THEN 1 ELSE 0 END),0) As NUM_SPEEDING_50,\n"
// 				+"coalesce(sum(CASE WHEN (q11.event_name = '17') THEN 1 ELSE 0 END),0) As NUM_SPEEDING_60,\n"
// 				+"coalesce(sum(CASE WHEN (q11.event_name = '16') THEN 1 ELSE 0 END),0) As NUM_SPEEDING_80\n"
// 			 	+"FROM \n"
// 				+"(SELECT DISTINCT positionreports.unit_id, positionreports.time,positionreports.date2,events.name AS event_name, accumscalamp.accum1,accumscalamp.accum2,accumscalamp.accum3,accumscalamp.accum7,accumscalamp.accum8 FROM positionreports\n"
// 				+"LEFT JOIN events ON positionreports.event_id = events.id\n"
// 				+"LEFT JOIN accumscalamp ON positionreports.accumscalamp_id = accumscalamp.id\n"
// 				+"WHERE \n"
// 				+"positionreports.date2 >= (current_date - interval '1 week')::date::date AND 	--PARAMETER START DATE\n"
// 				+"positionreports.date2 <= current_date::date AND 	--PARAMETER END DATE\n"
// 				+"accumscalamp.date2  >= (current_date - interval '1 week')::date AND\n"
// 				+"accumscalamp.date2 <= current_date::date AND\n"
// 				+"(events.name = '80' or events.name='0' or events.name = '13' or events.name = '12' or events.name='11' or events.name='10' or events.name='22' or events.name='17' or events.name='16'\n"
// 				+"or events.name='14' or events.name='15' or events.name='8' or events.name='Enter area'  or events.name='Leave area' or events.name='Enter area MANDATORY' or events.name='Enter area FORBIDDEN' ) AND\n"
// 				+"positionreports.company_id=109906326) AS q11 --PARAMETER COMPANY\n"
// 				+"GROUP BY date2 ORDER BY date2;\n";
				
		String query="SELECT 	date2,\n"
	+"coalesce(round(sum(CASE WHEN (q11.event_name = '0' or q11.event_name = '80') THEN q11.accum1 ELSE 0 END)*0.001,2),0) as KMS_GPS,\n"
	+"coalesce(round(sum(CASE WHEN (q11.event_name = '0' or q11.event_name = '80') THEN q11.accum7 ELSE 0 END)*1.0/3600,2),0) as DIVING_HOURS,\n"
	+"coalesce(round(sum(CASE WHEN (q11.event_name = '0' or q11.event_name = '80') THEN q11.accum8 ELSE 0 END)*1.0/3600,2),0) as IDLE_HOURS,\n"
	+"coalesce(SUM(CASE WHEN q11.event_name = '14' THEN 1 ELSE 0 END),0)  As ACCELERATION,\n"
	+"coalesce(SUM(CASE WHEN q11.event_name = '15' THEN 1 ELSE 0 END),0)  As BREAKING,\n"
	+"coalesce(SUM(CASE WHEN q11.event_name = '8' THEN 1 ELSE 0 END),0)  As IDLING,\n"
	+"coalesce(sum(CASE WHEN (q11.event_name = '13' or q11.event_name = '12' or q11.event_name = '11' or q11.event_name = '10' or q11.event_name = '22' or q11.event_name = '17' or q11.event_name = '16') THEN 1 ELSE 0 END),0) As NUM_SPEEDING,\n"
	+"coalesce(sum(CASE WHEN (q11.event_name = '13' or q11.event_name = '12' or q11.event_name = '11' or q11.event_name = '10' or q11.event_name = '22' or q11.event_name = '17' or q11.event_name = '16') THEN q11.accum3 ELSE 0 END),0) As SPEEDING_SEG_TOTAL,\n"
	+"coalesce(round(max(CASE WHEN (q11.event_name = '13' or q11.event_name = '12' or q11.event_name = '11' or q11.event_name = '10' or q11.event_name = '22' or q11.event_name = '17' or q11.event_name = '16') THEN q11.accum2 ELSE 0 END)*0.036),0) As MAX_SPEED_TOTAL,\n"
	+"coalesce(sum(CASE WHEN (q11.event_name = '13') THEN 1 ELSE 0 END),0) As NUM_SPEEDING_10,\n"
	+"coalesce(sum(CASE WHEN (q11.event_name = '12') THEN 1 ELSE 0 END),0) As NUM_SPEEDING_20,\n"
	+"coalesce(sum(CASE WHEN (q11.event_name = '11') THEN 1 ELSE 0 END),0) As NUM_SPEEDING_30,\n"
	+"coalesce(sum(CASE WHEN (q11.event_name = '10') THEN 1 ELSE 0 END),0) As NUM_SPEEDING_40,\n"
	+"coalesce(sum(CASE WHEN (q11.event_name = '22') THEN 1 ELSE 0 END),0) As NUM_SPEEDING_50,\n"
	+"coalesce(sum(CASE WHEN (q11.event_name = '17') THEN 1 ELSE 0 END),0) As NUM_SPEEDING_60,\n"
	+"coalesce(sum(CASE WHEN (q11.event_name = '16') THEN 1 ELSE 0 END),0) As NUM_SPEEDING_80,\n"
	+"count(DISTINCT(q11.unit_id * CASE WHEN (q11.event_name = '13' or q11.event_name = '12' or q11.event_name = '11' or q11.event_name = '10' or q11.event_name = '22' or q11.event_name = '17' or q11.event_name = '16')  THEN 1 ELSE NULL END)) As NUM_SPEEDIG_VEHICLES\n"
	
	+"FROM \n"
	+"(SELECT DISTINCT positionreports.unit_id, positionreports.time,positionreports.date2,events.name AS event_name, accumscalamp.accum1,accumscalamp.accum2,accumscalamp.accum3,accumscalamp.accum7,accumscalamp.accum8 FROM positionreports\n"
	+"LEFT JOIN events ON positionreports.event_id = events.id\n"
	+"LEFT JOIN accumscalamp ON positionreports.accumscalamp_id = accumscalamp.id\n"
	+"WHERE \n"
	+"positionreports.date2 >= (current_date - interval '1 week')::date::date AND 	--PARAMETER START DATE\n"
	+"positionreports.date2 <= current_date::date AND 	--PARAMETER END DATE\n"
	+"accumscalamp.date2  >= (current_date - interval '1 week')::date AND\n"
	+"accumscalamp.date2 <= current_date::date AND\n"
	+"(events.name = '80' or events.name='0' or events.name = '13' or events.name = '12' or events.name='11' or events.name='10' or events.name='22' or events.name='17' or events.name='16'\n"
	+"or events.name='14' or events.name='15' or events.name='8' or events.name='Enter area'  or events.name='Leave area' or events.name='Enter area MANDATORY' or events.name='Enter area FORBIDDEN' ) AND\n"
	+"positionreports.company_id=109906326) AS q11 --PARAMETER COMPANY\n"
	+"GROUP BY date2 ORDER BY date2;\n";


		//out.println(query);
		ResultSet rs=st.executeQuery(query);
		String fecha=null;
		float km_gps=0;
		float driving_hours=0;
		float idle_hours=0;	
		int breaking=0;
		int max_vel_total=0;
		float total_kms_gps=0;
		float total_diving_hours=0;
		float total_idle_hours=0;
		float total_hours=0;
		int max_speed_total=0;
		int num_speeding_10=0;
		int num_speeding_20=0;
		int num_speeding_30=0;
		int num_speeding_40=0;
		int num_speeding_50=0;
		int num_speeding_60=0;
		int num_speeding_80=0;	
		float total_excesosOver60=0;
		float num_speedig_vehicles=0;
		
		StringBuilder json = new StringBuilder();
		out.println("var chartData = [{");
		
		
		
		while (rs.next()){
			fecha=rs.getString("date2");
			km_gps=rs.getFloat("kms_gps");
			driving_hours=rs.getFloat("diving_hours");
			idle_hours=rs.getFloat("idle_hours");
			breaking=rs.getInt("breaking");
			
			total_kms_gps=total_kms_gps+rs.getFloat("kms_gps");
			total_diving_hours=total_diving_hours+rs.getFloat("diving_hours");
			total_idle_hours=total_idle_hours+rs.getFloat("idle_hours");
			
			
			max_speed_total=rs.getInt("max_speed_total");	
			num_speeding_10=rs.getInt("num_speeding_10");	
			num_speeding_20=rs.getInt("num_speeding_20");
			num_speeding_30=rs.getInt("num_speeding_30");
			num_speeding_40=rs.getInt("num_speeding_40");
			num_speeding_50=rs.getInt("num_speeding_50");
			num_speeding_60=rs.getInt("num_speeding_60");
			num_speeding_80=rs.getInt("num_speeding_80");
			
			total_excesosOver60=total_excesosOver60+num_speeding_60+num_speeding_80;
			num_speedig_vehicles=rs.getFloat("num_speedig_vehicles");
			
			
			json.append("\"fecha\": "+"\""+fecha+"\""+","+"\r");
			json.append("\"km_gps\": "+"\""+km_gps+"\""+","+"\r");
			json.append("\"driving_hours\": "+"\""+driving_hours+"\""+","+"\r");
			json.append("\"idle_hours\": "+"\""+idle_hours+"\""+","+"\r");
			json.append("\"breaking\": "+"\""+breaking+"\""+","+"\r");
			json.append("\"max_speed_total\": "+"\""+max_speed_total+"\""+","+"\r");
			json.append("\"num_speeding_10\": "+"\""+num_speeding_10+"\""+","+"\r");
			json.append("\"num_speeding_20\": "+"\""+num_speeding_20+"\""+","+"\r");
			json.append("\"num_speeding_30\": "+"\""+num_speeding_30+"\""+","+"\r");
			json.append("\"num_speeding_40\": "+"\""+num_speeding_40+"\""+","+"\r");
			json.append("\"num_speeding_50\": "+"\""+num_speeding_50+"\""+","+"\r");
			json.append("\"num_speeding_60\": "+"\""+num_speeding_60+"\""+","+"\r");
			json.append("\"num_speedig_vehicles\": "+"\""+num_speedig_vehicles+"\""+","+"\r");
			
			
			
			
			json.append("\"num_speeding_80\": "+"\""+num_speeding_80+"\""+"\r");
			json.append("}"+","+"{"+"\r");
		}
		String jsonstr=json.toString();
		jsonstr=jsonstr.substring(0, jsonstr.length()-3)+"];";
		out.println(jsonstr);	
		total_hours=total_diving_hours+total_idle_hours;
		float perc_diving_hours=(total_diving_hours/total_hours)*100;
		float perc_idle_hours=(total_idle_hours/total_hours)*100;
		out.println("//total_kms_gps: "+total_kms_gps+" total_diving_hours: "+total_diving_hours+" %:"+perc_diving_hours+" total_idle_hours: "+total_idle_hours+" %: "+perc_idle_hours);
		conDB.close();
		
		out.println("var total_horas_conduciendo="+total_diving_hours);
		out.println("var total_horas_idle="+total_idle_hours);
		out.println("var total_excesosOver60="+total_excesosOver60);
		
		out.println("var total_kms_gps="+total_kms_gps+";");
		
		out.println("var chartData1 = [{");
		out.println("\t\"phr\": "+"\"Horas Conduciendo\",");
		out.println("\t\"valor\": "+"\""+total_diving_hours+"\"");
		out.println("}, {");
		out.println("\t\"phr\": "+"\"Horas Ralenti\",");
		out.println("\t\"valor\": "+"\""+total_idle_hours+"\"");
		out.println("}];");
	%>
	</script>

	<div class='container color6'>  
        <div class="row">
            <div class="col-md-12 col-sm-12 text-center">
                <h2 class="font-green-sharp">Demo Tablero Coltrack</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="dashboard-stat2 ">
                    <div class="display">
                        <div class="number">
                            <small>Distancia Total Recorrida</small>
                            
                            <h3 class="font-green-sharp">
                                <span data-value="7800" data-counter="counterup">
                                    <script type="text/javascript">
                                        total_kms_gps=total_kms_gps.toFixed(1);
                                        document.write(total_kms_gps);                              
                                    </script>                               
                                </span>
                                <small class="font-green-sharp">Km</small>
                            </h3>
                        </div>
                    </div>
                </div>  
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="dashboard-stat2 ">
                    <div class="display">
                        <div class="number">
                            <small>Total Horas Conduciendo</small>
                            <h3 class="font-red-haze">
                                <span data-value="7800" data-counter="counterup">
                                    <script type="text/javascript">
                                        total_horas_conduciendo=total_horas_conduciendo.toFixed(0);
                                        document.write(total_horas_conduciendo);                                
                                    </script> 
                                </span>
                                <small class="font-red-haze"></small>
                            </h3>
                        </div>
                    </div>
                </div>  
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="dashboard-stat2 ">
                    <div class="display">
                        <div class="number">
                            <small>Total Horas Ralenti</small>
                            <h3 class="font-blue-sharp">
                                <span data-value="7800" data-counter="counterup">
                                    <script type="text/javascript">
                                        total_horas_idle=total_horas_idle.toFixed(0);
                                        document.write(total_horas_idle);                                
                                    </script> 

                                </span>
                                <small class="font-blue-sharp"></small>
                            </h3>
                        </div>
                    </div>
                </div>  
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="dashboard-stat2 ">
                    <div class="display">
                        <div class="number">
                            <small>Total Excesos>60Km/h</small>
                            <h3 class="font-purple-soft">
                                <span data-value="7800" data-counter="counterup">
                                    <script type="text/javascript">
                                        total_excesosOver60=total_excesosOver60.toFixed(0);
                                        document.write(total_excesosOver60);                                
                                    </script> 


                                </span>
                                <small class="font-purple-soft"></small>
                            </h3>
                        </div>
                    </div>
                </div>  
            </div>
        </div>  
        <div class="row">
            <div class="col-md-6 col-sm-12 text-center">
                <div class="bloques">
                    <h4 class="font-green-sharp">Distancia Maxima Horas</h4>
                    <!--  <div id="chartdiv" style="width: 640px; height: 400px;"></div>-->
                    <div id="chartdiv" style="width: 550px; height: 340px;"></div>
                </div>
            </div>
            <div class="col-md-6 col-sm-12 text-center">
                <div class="bloques">
                    <h4 class="font-green-sharp">Numero de Excesos</h4>
                    <div id="chartdiv1" style="width: 550px; height: 340px;"></div>
                </div>
            </div>
        </div>

        <div class="row">       
            <div class="col-md-6 col-sm-12 text-center">
                <div class="bloques">
                    <h4 class="font-green-sharp">Vehiculos Infractores Diarios</h4>
                    <div id="chartdiv2" style="width: 550px; height: 340px;"></div>
                </div>
            </div>
            <div class="col-md-6 col-sm-12 text-center">
                <div class="bloques">
                    <h4 class="font-green-sharp">Porcentajes Horas</h4>
                    <div id="chartdiv3" style="width: 600px; height: 440px;"></div>
                </div>  
            </div>      
        </div>  
    </div>
	
	<script src="amcharts/amcharts.js" type="text/javascript"></script>
	<script src="amcharts/serial.js" type="text/javascript"></script>	
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <script src="amcharts/pie.js" type="text/javascript"></script>

	<script type="text/javascript">
    AmCharts.ready(function(){
        var chart = new AmCharts.AmSerialChart();
        chart.dataProvider = chartData;
        chart.categoryField = "fecha";

        var categoryAxis = chart.categoryAxis;
        categoryAxis.autoGridCount  = false;
        categoryAxis.gridCount = chartData.length;
        categoryAxis.gridPosition = "start";
        categoryAxis.labelRotation = 45;
        categoryAxis.gridAlpha = 0.1;
        categoryAxis.axisAlpha = 0;
        categoryAxis.color="#6c7b88";
        categoryAxis.titleColor="#6c7b88";
        
        var valueAxis = new AmCharts.ValueAxis();
        valueAxis.title = "Distancia en Km";
        valueAxis.dashLength = 1;
        valueAxis.color="#6c7b88";
        valueAxis.titleColor="#6c7b88";
        chart.addValueAxis(valueAxis);
        
        var horasAxis = new AmCharts.ValueAxis();
        horasAxis.gridAlpha = 0;
        horasAxis.axisAlpha = 0;
        horasAxis.dashLength = 5;
        horasAxis.title = "Horas";
        horasAxis.offset = 5;
        horasAxis.titleOffset = 10;
        horasAxis.position = "right";
        horasAxis.stackType = "regular";
        horasAxis.gridAlpha = 0.1;
        horasAxis.axisAlpha = 0;
        horasAxis.color="#6c7b88";
        horasAxis.titleColor="#6c7b88";
        chart.addValueAxis(horasAxis);

        var graph3 = new AmCharts.AmGraph();
        graph3.type = "column";
        graph3.title = "Horas ralenti";
        graph3.lineColor = "#f36a5a";
        graph3.valueField = "idle_hours";
        graph3.lineAlpha = 0;
        graph3.fillAlphas = 1;
        graph3.dashLengthField = "dashLengthColumn";
        graph3.alphaField = "alpha";
        graph3.balloonText = "<span style='font-size:13px;'>[[title]] en [[category]]:<b>[[value]]</b> [[additional]]</span>";
        graph3.valueAxis = horasAxis; 
        chart.addGraph(graph3);

        var graph1 = new AmCharts.AmGraph();
        graph1.type = "column";
        graph1.title = "Horas conduciendo";
        graph1.lineColor = "#2ab4c0";
        graph1.valueField = "driving_hours";
        graph1.lineAlpha = 0;
        graph1.fillAlphas = 1;
        graph1.dashLengthField = "dashLengthColumn";
        graph1.alphaField = "alpha";
        graph1.balloonText = "<span style='font-size:13px;'>[[title]] en [[category]]:<b>[[value]]</b> [[additional]]</span>";
        graph1.valueAxis = horasAxis; 
        chart.addGraph(graph1);

        var graph2 = new AmCharts.AmGraph();
        graph2.title = "Distancia Recorrida en Km";
        graph2.labelPosition= "top";
        graph2.valueField = "km_gps";
        graph2.type = "smoothedLine";       
        graph2.lineColor = "#8A4B08";
        graph2.lineThickness = 3;
        graph2.bullet = "round";
        graph2.bulletBorderThickness = 3;
        graph2.bulletBorderColor = "#8A4B08";
        graph2.bulletBorderAlpha = 1;
        graph2.bulletColor = "#ffffff";
        graph2.dashLengthField = "dashLengthLine";
        graph2.balloonText = "<span style='font-size:13px;'>Distancia:[[value]] Km</span>";
        graph2.valueAxis = valueAxis;
        chart.addGraph(graph2);
        
        // LEGEND
        var legend = new AmCharts.AmLegend();
        //legend.useGraphSettings = true;
        legend.fontSize=8;
        chart.addLegend(legend);
        
        chart.write('chartdiv');
        
        /////////////////////////////////////////////////////////////////////////////////////       
        //GRAFICA EXCESOS
        var chart1 = new AmCharts.AmSerialChart();
        chart1.dataProvider = chartData;
        chart1.categoryField = "fecha";

        var categoryAxisExcesos = chart1.categoryAxis;
        categoryAxisExcesos.autoGridCount  = false;
        categoryAxisExcesos.gridCount = chartData.length;
        categoryAxisExcesos.gridPosition = "start";
        categoryAxisExcesos.labelRotation = 45;
        categoryAxisExcesos.gridAlpha = 0.1;
        categoryAxisExcesos.axisAlpha = 0;
        categoryAxisExcesos.color="#6c7b88";
        categoryAxisExcesos.titleColor="#6c7b88";
        
        var valueAxisExcesos = new AmCharts.ValueAxis();
        valueAxisExcesos.title = "Excesos de Velocidad";
        valueAxisExcesos.gridAlpha = 0;
        valueAxisExcesos.axisAlpha = 0;
        valueAxisExcesos.dashLength = 5;
        valueAxisExcesos.offset = 5;
        valueAxisExcesos.titleOffset = 1;
        valueAxisExcesos.position = "left";
        valueAxisExcesos.stackType = "regular";
        valueAxisExcesos.gridAlpha = 0.1;
        valueAxisExcesos.axisAlpha = 0;
        valueAxisExcesos.color="#6c7b88";
        valueAxisExcesos.titleColor="#6c7b88";
        chart1.addValueAxis(valueAxisExcesos);

        var graphExc1 = new AmCharts.AmGraph();
        graphExc1.type = "column";
        graphExc1.title = "Excesos 10Km/h";
        graphExc1.lineColor = "#81F781";
        graphExc1.valueField = "num_speeding_10";
        graphExc1.lineAlpha = 0;
        graphExc1.fillAlphas = 1;
        graphExc1.dashLengthField = "dashLengthColumn";
        graphExc1.alphaField = "alpha";
        graphExc1.balloonText = "<span style='font-size:13px;'>[[title]] en [[category]]:<b>[[value]]</b> [[additional]]</span>";
        graphExc1.valueAxis = valueAxisExcesos; 
        chart1.addGraph(graphExc1);

        var graphExc2 = new AmCharts.AmGraph();
        graphExc2.type = "column";
        graphExc2.title = "Excesos 20Km/h";
        graphExc2.lineColor = "#2EFE2E";
        graphExc2.valueField = "num_speeding_20";
        graphExc2.lineAlpha = 0;
        graphExc2.fillAlphas = 1;
        graphExc2.dashLengthField = "dashLengthColumn";
        graphExc2.alphaField = "alpha";
        graphExc2.balloonText = "<span style='font-size:13px;'>[[title]] en [[category]]:<b>[[value]]</b> [[additional]]</span>";
        graphExc2.valueAxis = valueAxisExcesos; 
        chart1.addGraph(graphExc2);

        var graphExc3 = new AmCharts.AmGraph();
        graphExc3.type = "column";
        graphExc3.title = "Excesos 30Km/h";
        graphExc3.lineColor = "#A5DF00";
        graphExc3.valueField = "num_speeding_30";
        graphExc3.lineAlpha = 0;
        graphExc3.fillAlphas = 1;
        graphExc3.dashLengthField = "dashLengthColumn";
        graphExc3.alphaField = "alpha";
        graphExc3.balloonText = "<span style='font-size:13px;'>[[title]] en [[category]]:<b>[[value]]</b> [[additional]]</span>";
        graphExc3.valueAxis = valueAxisExcesos; 
        chart1.addGraph(graphExc3);

        var graphExc4 = new AmCharts.AmGraph();
        graphExc4.type = "column";
        graphExc4.title = "Excesos 40Km/h";
        graphExc4.lineColor = "#FFFF00";
        graphExc4.valueField = "num_speeding_40";
        graphExc4.lineAlpha = 0;
        graphExc4.fillAlphas = 1;
        graphExc4.dashLengthField = "dashLengthColumn";
        graphExc4.alphaField = "alpha";
        graphExc4.balloonText = "<span style='font-size:13px;'>[[title]] en [[category]]:<b>[[value]]</b> [[additional]]</span>";
        graphExc4.valueAxis = valueAxisExcesos; 
        chart1.addGraph(graphExc4);

        var graphExc5 = new AmCharts.AmGraph();
        graphExc5.type = "column";
        graphExc5.title = "Excesos 50Km/h";
        graphExc5.lineColor = "#F7BE81";
        graphExc5.valueField = "num_speeding_50";
        graphExc5.lineAlpha = 0;
        graphExc5.fillAlphas = 1;
        graphExc5.dashLengthField = "dashLengthColumn";
        graphExc5.alphaField = "alpha";
        graphExc5.balloonText = "<span style='font-size:13px;'>[[title]] en [[category]]:<b>[[value]]</b> [[additional]]</span>";
        graphExc5.valueAxis = valueAxisExcesos; 
        chart1.addGraph(graphExc5);

        var graphExc6 = new AmCharts.AmGraph();
        graphExc6.type = "column";
        graphExc6.title = "Excesos 60Km/h";
        graphExc6.lineColor = "#FA8258";
        graphExc6.valueField = "num_speeding_60";
        graphExc6.lineAlpha = 0;
        graphExc6.fillAlphas = 1;
        graphExc6.dashLengthField = "dashLengthColumn";
        graphExc6.alphaField = "alpha";
        graphExc6.balloonText = "<span style='font-size:13px;'>[[title]] en [[category]]:<b>[[value]]</b> [[additional]]</span>";
        graphExc6.valueAxis = valueAxisExcesos; 
        chart1.addGraph(graphExc6);

        // var graphExc7 = new AmCharts.AmGraph();
        // graphExc7.type = "column";
        // graphExc7.title = "Excesos 70Km/h";
        // graphExc7.lineColor = "#FE2E2E";
        // graphExc7.valueField = "num_speeding_70";
        // graphExc7.lineAlpha = 0;
        // graphExc7.fillAlphas = 1;
        // graphExc7.dashLengthField = "dashLengthColumn";
        // graphExc7.alphaField = "alpha";
        // graphExc7.balloonText = "<span style='font-size:13px;'>[[title]] en [[category]]:<b>[[value]]</b> [[additional]]</span>";
        // graphExc7.valueAxis = valueAxisExcesos; 
        // chart1.addGraph(graphExc7);

        var graphExc8 = new AmCharts.AmGraph();
        graphExc8.type = "column";
        graphExc8.title = "Excesos 80Km/h";
        graphExc8.lineColor = "#DF0101";
        graphExc8.valueField = "num_speeding_80";
        graphExc8.lineAlpha = 0;
        graphExc8.fillAlphas = 1;
        graphExc8.dashLengthField = "dashLengthColumn";
        graphExc8.alphaField = "alpha";
        graphExc8.balloonText = "<span style='font-size:13px;'>[[title]] en [[category]]:<b>[[value]]</b> [[additional]]</span>";
        graphExc8.valueAxis = valueAxisExcesos; 
        chart1.addGraph(graphExc8);

        //Grafica Maxima Velocidad

        var maxVelAxis = new AmCharts.ValueAxis();
        maxVelAxis.gridAlpha = 0;
        maxVelAxis.axisAlpha = 0;
        maxVelAxis.dashLength = 5;
        maxVelAxis.title = "Maxima Velocidad Km/h";
        maxVelAxis.offset = 5;
        maxVelAxis.titleOffset = 2;
        maxVelAxis.position = "right";
        maxVelAxis.stackType = "regular";
        maxVelAxis.gridAlpha = 0.1;
        maxVelAxis.axisAlpha = 0;
        maxVelAxis.color="#6c7b88";
        maxVelAxis.titleColor="#6c7b88";
        chart1.addValueAxis(maxVelAxis);

        var graphMaxVel = new AmCharts.AmGraph();
        graphMaxVel.title = "Maxima Velocidad";
        //graphMaxVel.labelPosition= "top";
        graphMaxVel.valueField = "max_speed_total";
        graphMaxVel.type = "smoothedLine";      
        graphMaxVel.lineColor = "#8A4B08";
        graphMaxVel.lineThickness = 3;
        graphMaxVel.bullet = "round";
        graphMaxVel.bulletBorderThickness = 3;
        graphMaxVel.bulletBorderColor = "#8A4B08";
        graphMaxVel.bulletBorderAlpha = 1;
        graphMaxVel.bulletColor = "#ffffff";
        graphMaxVel.dashLengthField = "dashLengthLine";
        graphMaxVel.balloonText = "<span style='font-size:13px;'>Distancia:[[value]] Km</span>";
        graphMaxVel.valueAxis = maxVelAxis;
        chart1.addGraph(graphMaxVel);

        // LEGEND
        var legend1 = new AmCharts.AmLegend();
        //legend1.useGraphSettings = true;
        legend1.fontSize=8;
        chart1.addLegend(legend1);

        chart1.write('chartdiv1');
        //////////////////////////////////////////////
        //GRAFICA VEHICULOS INFRACTORES
        
        var chart2 = new AmCharts.AmSerialChart();
        chart2.dataProvider = chartData;
        chart2.categoryField = "fecha";
        chart2.angle = 30;
        chart2.depth3D = 15;
        chart2.backgroundColor="ffffff";

        var valueAxisi = new AmCharts.ValueAxis();
        valueAxisi.title = "Numero Vehiculos Infractores";
        valueAxisi.dashLength = 1;
        valueAxisi.titleColor="#6c7b88";
        chart2.addValueAxis(valueAxisi);
                  
        var graphi = new AmCharts.AmGraph();
        graphi.valueField = "num_speedig_vehicles";
        graphi.type = "column";
        graphi.fillAlphas = 0.8;
        graphi.balloonText = "Vehiculos Infractores: <b>[[value]]</b>";
        graphi.lineColor="#f36a5a";
        chart2.addGraph(graphi);

        var categoryAxisi = chart2.categoryAxis;
        categoryAxisi.autoGridCount  = false;
        categoryAxisi.gridCount = chartData.length;
        categoryAxisi.gridPosition = "start";
        categoryAxisi.labelRotation = 45;
        categoryAxisi.color="#6c7b88";
        categoryAxisi.titleColor="#6c7b88";
        chart2.write('chartdiv2');  

        //PIE CHART
        var chart3 = new AmCharts.AmPieChart();
        chart3.colors=  ["#2ab4c0", "#f36a5a", "#FF9E01", "#FCD202", "#F8FF01", "#B0DE09", "#04D215", "#0D8ECF", "#0D52D1", "#2A0CD0", "#8A0CCF", "#CD0D74", "#754DEB", "#DDDDDD", "#999999", "#333333", "#000000", "#57032A", "#CA9726", "#990000", "#4B0C25"];
        chart3.dataProvider = chartData1;
        chart3.titleField = "phr";
        chart3.valueField = "valor";
        // LEGEND
        legendp = new AmCharts.AmLegend();
        legendp.align = "center";
        legendp.markerType = "circle";
        chart3.balloonText = "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>";
        chart3.addLegend(legendp);
        legendp.fontSize=10;
        chart3.write("chartdiv3");  
    });
    </script>
</body>
	


</body>
</html>