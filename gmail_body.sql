USE [newone]
GO

/****** Object:  View [dbo].[salesinformati]    Script Date: 04.02.2023 23:49:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[salesinformati]
as 
select  sened_nomresi [Müştəri Sənəd Nəmrəsi],
tarix as Tarix,
[Müştəri Adı],
Ünvan ,
[Müştəri Meyili],
        
		
		[Məhsul Adı],
		satis_qiymeti as [Satış Qiyməti],
		satis_meblegi as [Satış Məbləği],	
		miqdar as [Miqdar],
		
		qeyd as Qeyd
		from satis_mallar3 s
inner join satis_senedi m
on s.sened_nomre = m.sened_nomresi;
GO
 
DECLARE @MAIL_BODY NVARCHAR(4000)
 
/* HEADER */
SET @MAIL_BODY = 

N'<table border="1" align="center" cellpadding="2" cellspacing="0" style="color:black;font-family:consolas;text-align:center;">' +
    N'<tr>
    <th>Müştəri Sənəd Nəmrəsi</th>
	<th>Tarix</th>
	<th>Müştəri Adı</th>
    <th>Ünvan</th>
    <th>Müştəri Meyili</th>
	<th>Məhsul Adı</th>
	<th>Satış Qiyməti</th>
	<th>Satış Məbləği</th>
	<th>Miqdar</th>
	<th>Qeyd</th>
    </tr>'
 
/* ROWS */
SELECT
     @MAIL_BODY = @MAIL_BODY +
        N'<tr>' +
        N'<td>' + CAST([Müştəri Sənəd Nəmrəsi] AS varchar(11)) + '</td>' +
        N'<td>' + CAST(Tarix as varchar(30)) + '</td>' +
        N'<td>' + CAST([Müştəri Adı] AS varchar(11)) + '</td>' +
        N'<td>' + CAST(Ünvan AS nvarchar(11)) + '</td>' +
		N'<td>' + cast([Müştəri Meyili] as varchar(30)) + '</td>'+
		N'<td>' + cast([Məhsul Adı] as varchar(30)) + '</td>'+
		N'<td>' + cast([Satış Qiyməti] as varchar(30)) + '</td>'+
		N'<td>' + cast([Satış Məbləği] as varchar(30)) + '</td>'+
		N'<td>' + cast(Miqdar as varchar(30)) + '</td>'+
		N'<td>' + cast(Qeyd as varchar(30)) + '</td>'+		
   '</tr>'
FROM salesinformati
   
 
SELECT  @MAIL_BODY = @MAIL_BODY + '</table>'
 
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'seymur1',
	@recipients = "recipient's mail",
    @subject = N'Günlük Satışlarınız Xeyirli Olsun :)',
    @body = @MAIL_BODY,
    @body_format='HTML';

	


