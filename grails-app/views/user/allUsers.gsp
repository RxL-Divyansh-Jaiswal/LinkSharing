<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="https://kit.fontawesome.com/75cf4e84e0.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <asset:stylesheet src="user/allUsers.css"></asset:stylesheet>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>
    <asset:javascript src="searchTopic.js"></asset:javascript>
    <script>
        var dataUrl = "${createLink(controller: 'topic', action: 'searchTopics')}"
    </script>
    <script type="text/javascript">
        $(document).ready( function () {
            $('#table_id').DataTable();
        });

        $('#table_id').DataTable( {
            "columnDefs": [
                {"className": "dt-center", "targets": "_all"}
            ]
        } );
    </script>
    <title>ADMIN PAGE</title>
</head>
<body>
<!-- navbar -->
<div id="navbar">
    <g:link controller="home" action="home" class="homeLink">Link Sharing</g:link>

    <div class="navigator">
        <ul>
            <li>
                <input type="text" id="search_text" name="search" placeholder="Search...">
                <button id="search_btn"><i class="fas fa-search"></i></button>
            </li>
            <li><button data-bs-toggle="modal" data-bs-target="#topicModal"><i class="fas fa-comment"></i></button>
            </li>
            <li><button data-bs-toggle="modal" data-bs-target="#inviteModal"><i class="far fa-envelope"></i>
            </button>
            </li>
            <li><button data-bs-toggle="modal" data-bs-target="#linkModal"><i class="fas fa-link"></i></button></li>
            <li><button data-bs-toggle="modal" data-bs-target="#docModal"><i class="fas fa-file"></i></button></li>
            <li>
                <div class="settings">
                    <button class="settings_btn" style="font-size: 1.5rem;">${session.user.userName}</button>

                    <div class="settings_opt">
                        <g:if test="${session.user.admin}">
                            <g:link controller="user" action="getProfile" id="${session.user.id}">Profile</g:link>
                            <g:link controller="user" action="allUsers">Users</g:link>
                            <g:link controller="user" action="logout">Logout</g:link>
                        </g:if>
                        <g:else>
                            <g:link controller="user" action="getProfile" id="${session.user.id}">Profile</g:link>
                            <g:link controller="user" action="logout">Logout</g:link>
                        </g:else>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>

<!-- modals -->
<g:render template="/templates/modals"/>

<h3 class="success">${flash.logSuccess}</h3>

<h3 class="success">${flash.topicSuccess}</h3>

<h3 class="success">${flash.linkResSuccess}</h3>

<h3 class="success">${flash.docResSuccess}</h3>

<h3 class="error">${flash.topicError}</h3>

<h3 class="error">${flash.linkResError}</h3>

<h3 class="error">${flash.docResError}</h3>

<h3 class="success">${flash.statusMsg}</h3>

<div class="search_results"></div>

<!-- table -->
<table id="table_id" class="display" data-page-length='20'>
    <thead>
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>E-mail</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Active</th>
        <th>Manage</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${users}" var="i">
        <g:if test="${i.admin == false}">
            <tr>
                <td>${i.id}</td>
                <td><g:link controller="user" action="getProfile" id="${i.id}" style="text-decoration: none; color: darkred;">@${i.userName}</g:link></td>
                <td>${i.email}</td>
                <td>${i.firstName}</td>
                <td>${i.lastName}</td>
                <g:if test="${i.active}">
                    <td>Yes</td>
                    <td><g:link controller="user" action="deactivateUser" id="${i.id}" class="deactivate">Deactivate</g:link></td>
                </g:if>
                <g:else>
                    <td>No</td>
                    <td><g:link controller="user" action="activateUser" id="${i.id}" class="activate">Activate</g:link></td>
                </g:else>
            </tr>
        </g:if>
    </g:each>
    </tbody>
</table>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>