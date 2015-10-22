<%@ taglib prefix="sm" uri="http://jsmartframework.com/v2/jsp/taglib/jsmart" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>JSmart Framework - File Archetype</title>
    </head>

    <body class="container">

        <!-- Example list and table handling -->

        <div class="col-md-6" style="margin-top: 50px;">

            <sm:alert id="feedback">
                <!-- Message will be added via WebContext on HomeBean -->

                <div style="text-align: right;">
                    <sm:button label="I got it!" onClick="$('#feedback').alert('close');" />
                </div>
            </sm:alert>

            <sm:form>
                <sm:output type="p" value="Enter name and age to be included on list" style="text-align: center;" />

                <sm:input id="name-id" label="Name" placeholder="Enter name" value="@{homeBean.name}">
                    <sm:validate look="warning" text="Name must be valid" />
                </sm:input>

                <sm:input id="name-id" type="number" label="Age" placeholder="Enter age" value="@{homeBean.age}">
                    <sm:validate look="warning" text="Age must be valid" />
                </sm:input>

                <sm:button id="add-btn" ajax="true" label="Send" action="@{homeBean.addContent}" update="list"
                        beforeSend="updateActionTables();">
                    <sm:load />
                    <sm:icon name="glyphicon-pencil" />
                </sm:button>

            </sm:form>
        </div>

        <div class="col-md-6" style="margin-top: 50px;">
            <sm:list id="list" values="@{homeBean.myListAdapter}" var="item" scrollSize="10" maxHeight="500px;">

                <!-- Load component will present loading when request is done to get more list items via scroll -->
                <sm:load type="h4" label=" Loading ..." />

                <!-- Template to create each list row -->
                <sm:row>
                    <sm:header title="@{item.name}" />

                    <sm:badge label="@{item.age}" />
                </sm:row>

                <!-- Component to present content when list is empty -->
                <sm:empty style="color: #ddd; font-size: 18px; text-align: center;">
                    <sm:icon name="glyphicon-user" />
                    <sm:output value="No items found on list" />
                </sm:empty>

            </sm:list>
        </div>

        <div class="col-md-6" style="margin-top: 30px;">

            <sm:table id="table" striped="true">

                <sm:column label="Action">
                    <sm:output id="action-id" />
                </sm:column>

                <sm:empty style="color: #ddd; font-size: 18px; text-align: center;">
                    <sm:icon name="glyphicon-bell" />
                    <sm:output value="No actions found on table" />
                </sm:empty>
            </sm:table>
        </div>

        <!-- Upload status functions -->
        <script type="text/javascript">

            /*!
             * Called before action via Ajax is done on server to keep track of clients action
             */
            function updateActionTables() {
                JSmart.setProgressBar('upload-status', percent);
            }
        </script>
    </body>

</html>