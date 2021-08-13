<script src="https://kit.fontawesome.com/75cf4e84e0.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<asset:stylesheet src="modals.css"></asset:stylesheet>

<!-- create topic -->
<div class="modal fade" id="topicModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Create Topic</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <g:form controller="topic" action="createTopic" method="post">
                    <label>Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="name" placeholder="(max 20 characters)" required>
                    <br>
                    <label>Visibility&nbsp;</label>
                    <select style="margin-top: 1%;" name="visibility">
                        <option value="Public">Public</option>
                        <option value="Private">Private</option>
                    </select>
                    <br>
                    <input class="form_btn" type="submit" value="Create">
                </g:form>
            </div>
        </div>
    </div>
</div>

<!-- share document -->
<div class="modal fade" id="docModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Share Document</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <g:form controller="topic" action="addDocResource" method="post" enctype="multipart/form-data">
                    <label>Document</label>
                    <input type="file" name="doc" required>
                    <br>
                    <label style="vertical-align: top;">Description</label>
                    <textarea id="desp" name="description" rows="2" cols="35" style="margin-top: 2%;"
                              placeholder="This document is about... (upto 1000 characters)" required></textarea>
                    <br>
                    <label>Topic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <select name="topic" style="margin-top: 1%;">
                        <g:each in="${linksharing.Topic.list()}" var="i">
                            <option value="${i.name}">${i.name}</option>
                        </g:each>
                    </select>
                    <br>
                    <input class="form_btn" type="submit" value="Share">
                </g:form>
            </div>
        </div>
    </div>
</div>

<!-- share link -->
<div class="modal fade" id="linkModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Share Link</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <g:form controller="topic" action="addLinkResource" method="post">
                    <label>Link&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="link" name="url" required>
                    <br>
                    <label style="vertical-align: top;">Description</label>
                    <textarea id="desp" name="description" rows="2" cols="35" style="margin-top: 2%;"
                              placeholder="This link is about... (upto 1000 characters)" required></textarea>
                    <br>
                    <label>Topic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <select name="topic" style="margin-top: 1%;">
                        <g:each in="${linksharing.Topic.list()}" var="i">
                            <option value="${i.name}">${i.name}</option>
                        </g:each>
                    </select>
                    <br>
                    <input class="form_btn" type="submit" value="Share">
                </g:form>
            </div>
        </div>
    </div>
</div>

<!-- send invite -->
<div class="modal fade" id="inviteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Send Invitation</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <g:form controller="topic" action="sendInvite" method="post">
                    <label>Email&nbsp;&nbsp;&nbsp;</label>
                    <input type="email" name="email" required>
                    <br>
                    <label>Topic&nbsp;&nbsp;&nbsp;</label>
                    <select name="topic" style="margin-top: 1%;">
                        <g:each in="${linksharing.Topic.list()}" var="i">
                            <option value="${i.name}">${i.name}</option>
                        </g:each>
                    </select>
                    <br>
                    <input class="form_btn" type="submit" value="Invite">
                </g:form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>