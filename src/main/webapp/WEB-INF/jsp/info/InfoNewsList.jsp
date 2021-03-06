<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_ADD')">
			<span class="opb lb op-area"><a href="<s:url namespace="/info" action="news_load"><s:param name="viewFlag">add</s:param></s:url>" >添加信息</a></span>
		</s:if>
	</div>
	<s:form id="serachForm" name="serachForm" action="news_list"  method="get" namespace="/info" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">标题:</div>
				       <div class="label_rwbenx"><s:textfield id="news.title" title="标题" name="news.title" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">类别:</div>
				       <div class="label_rwbenx">
				       		<s:hidden id="news.class_id" title="信息类别" name="news.class_id" />
				       		<s:textfield id="news.class_name" title="信息类别" name="news.class_name" readonly="true" /><img id="class_detail_open" class="detail vatop" src='<s:url value="/images/open2.gif" />'  />
				       </div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">状态:</div>
				       <div class="label_rwbenx"><s:select id="news.ischecked" title="状态" name="news.ischecked" headerKey="" headerValue="-请选择-" list="#{-1:'未提交',0:'待初审',1:'初审退回',2:'初审通过',3:'终审退回',4:'终审通过'}" /></div>
				</div>
				<div class="label_hang label_button tac">
		        	<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
					<label for="search_mcondition"></label>更多条件
		            <s:submit value="搜索" /> <s:reset value="重置" />
		        </div>
			</div>
		</div>
	</s:form>
	<div class="tab_warp">
	 		<table id="table1">
	 			<tr id="coltr">
	              <th  class="td1">编号</th>
	              <th  class="td1">类别</th>
	              <th  class="td2">标题</th>
	              <th  class="td3">发布人</th>
	              <th  class="td3">发布时间</th>
	              <th  class="td4">置顶</th>
	              <th  class="td4">状态</th>
	              <th  class="td5">操作</th>
	              <th  class="td0">查看</th>
	            </tr>
	            <s:iterator value="newsx" status="sta">
	            	<tr id="showtr${uuid}">
	            		  <td  class="td1">${uuid}</td>
			              <td  class="td1">${class_name}</td>
			              <td  class="td2 longnote" title="${title}">
			              <a href="<s:url namespace="/info" action="news_view"><s:param name="viewFlag">view</s:param><s:param name="news.uuid" value="uuid" /></s:url>" target="_blank">${it:subString(title,18)}</a>
			              </td>
			              <td  class="td3">${add_user_name}</td>
			              <td  class="td3">${it:formatDate(add_time,'yyyy-MM-dd HH:mm:ss')}</td>
			              <td  class="td4">
			              		<s:if test="istop==0">未置顶</s:if>
		              			<s:elseif test="istop>0">
									<span style="color: red;">已置顶(<s:property value="istop" />)</span>
								</s:elseif>
			              </td>
			              <td  class="td4">
			              		<s:if test="ischecked==0">
									<span style="color: red;">待初审</span>
								</s:if> <s:elseif test="ischecked==-1">未提交</s:elseif> <s:elseif test="ischecked==1">
									<span style="color: yellow;">初审退回</span>
								</s:elseif> <s:elseif test="ischecked==2">
									<span style="color: green;">初审通过</span>
								</s:elseif> <s:elseif test="ischecked==3">
									<span style="color: red;">终审退回</span>
								</s:elseif> <s:elseif test="ischecked==4">
									<span style="color: gray;">终审通过</span>
								</s:elseif> <s:else>
									<span style="color: red; font-weight: bold;">状态异常,请通知管理员</span>
								</s:else>
			              </td>
			              <td  class="td5 op-area"">
			              		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_MDY')">
						    		<a class="input-blue" href="<s:url namespace="/info" action="news_load"><s:param name="viewFlag">mdy</s:param><s:param name="news.uuid" value="uuid"></s:param></s:url>">修改</a>
						    	</s:if>
						    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMER_DEL')">
						    		<a class="input-red" href="<s:url namespace="/info" action="news_saveDel"><s:param name="news.uuid" value="uuid" /><s:param name="news.isdel">1</s:param></s:url>" onclick="return isDel('把记录放进回收站吗?');">回收</a>
						    	</s:if>	  
			              </td>
			              <td  class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
	            	</tr>
	            </s:iterator>
	       </table>
	       <div class="pagination">
			<div id="listpage" class="pagination"></div>
		</div>
	 </div>
</div>
</div>

<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<div id="selectInfoClass" style="display: none;">
	<div class="dtree2" style="overflow: scroll; height: 300px;border: none;">
		<!--<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>-->
		<script type="text/javascript">
	var d2 = new dTree('d2');
	d2.config.check = 2;
	d2.config.useIcons = false;
	//d.config.isAddNoRootNode = true;
	d2.icon = {
			root		: '<s:url value="/include/dtree/" />'+'img/globe.gif',
			folder		: '<s:url value="/include/dtree/" />'+'img/folder.gif',
			folderOpen	: '<s:url value="/include/dtree/" />'+'img/folderopen.gif',
			node		: '<s:url value="/include/dtree/" />'+'img/page.gif',
			empty		: '<s:url value="/include/dtree/" />'+'img/empty.gif',
			line		: '<s:url value="/include/dtree/" />'+'img/line.gif',
			join		: '<s:url value="/include/dtree/" />'+'img/join.gif',
			joinBottom	: '<s:url value="/include/dtree/" />'+'img/joinbottom.gif',
			plus		: '<s:url value="/include/dtree/" />'+'img/plus.gif',
			plusBottom	: '<s:url value="/include/dtree/" />'+'img/plusbottom.gif',
			minus		: '<s:url value="/include/dtree/" />'+'img/minus.gif',
			minusBottom	: '<s:url value="/include/dtree/" />'+'img/minusbottom.gif',
			nlPlus		: '<s:url value="/include/dtree/" />'+'img/nolines_plus.gif',
			nlMinus		: '<s:url value="/include/dtree/" />'+'img/nolines_minus.gif'
	};		
	d2.add('0','-1','信息类别列表');
	<s:iterator value="iclasses">
	d2.add('<s:property value="uuid" />','<s:property value="parent_id" />','<s:property value="title" />',"javascript:getInfo('<s:property value="uuid" />')",'<s:property value="title" />');
	</s:iterator>
	d2.add();
	document.write(d2);
	function setCheckValue() {
		var deptInfo = getCheckBox("cd2");
		if(null==deptInfo||""==deptInfo) {
			if(window.confirm("没有选择任何部门,是否确认?")) {
				closemDiv();
			}
		} else {
			alert(deptInfo[1]);
			$("#news\\.class_id").val(deptInfo[1]);
			$("#news\\.class_name").val(deptInfo[2]);
			closemDiv();
		}
	}
</script>
	</div>
	<div class="dtreebutton" style="border: none;">
		<input type="button" value="确定" onclick="setCheckValue();" /> <input type="button" value="返回" onclick="closemDiv();" />
	</div>
</div>
<script type="text/javascript">

/* var md;
var ___select_infoclass_html_value;
window.onload = function() {
	___select_infoclass_html_value = $('#selectInfoClass').html();
	$('#selectInfoClass').empty();
};
function selectClass() {	
	md = new modelDiv();
	md.setTitle_HTML("");
	md.setBottom_HTML("");
	md.createModelDivByContent(220,300,___select_infoclass_html_value);	
}
function closemDiv() {
	md.dropModelDiv();
} */
var md;
function closemDiv() {
	 $("#selectInfoClass").dialog("close");
}

$(function(){
 $("#selectInfoClass").dialog({ autoOpen : false,
		modal : true });
 
 $("#class_detail_open").click(function(){
	 $("#selectInfoClass").dialog("open");
 });
});
</script>
<script type="text/javascript">
$(function(){
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
});
</script>
</body>
</html>