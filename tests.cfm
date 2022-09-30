<cfscript>
    writeoutput(timeFormat(now(), "hh:mm:ss") & "<br/>");
    writeoutput(timeFormat(now(), "hh:mm:ss, z") & "<br/>");
    writeoutput(timeFormat(now(), "hh:mm:ss, Z") & "<br/>");
    writeoutput(timeFormat(now(), "hh:mm:ss, X") & "<br/>");
    writeoutput(timeFormat(now(), "hh:mm:ss, XX") & "<br/>");
    writeoutput(timeFormat(now(), "hh:mm:ss, XXX") & "<br/>");
</cfscript>

 <cfscript>
     curdatetime = now();
     writeOutput("The local date and time are " & curdatetime & "<br/>");
     info = GetTimeZoneInfo();
     writeOutput("Total offset in seconds is " & info.utcTotalOffset & "<br/>");
     writeOutput("Offset in hours is " & info.utcHourOffset & "<br/>");
     writeOutput("Total offset in minutes minus is " & info.utcMinuteOffset & "<br/>");
     writeOutput("Total offset in seconds is " & info.isDSTOn & "<br/>");
 </cfscript>