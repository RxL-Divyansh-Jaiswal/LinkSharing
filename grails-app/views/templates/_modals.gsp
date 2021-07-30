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
                <form>
                    <label>Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text">
                    <br>
                    <label>Visibility&nbsp;</label>
                    <select style="margin-top: 1%;">
                        <option>Public</option>
                        <option>Private</option>
                    </select>
                    <br>
                    <input class="form_btn" type="submit" value="Create">
                </form>
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
                <form>
                    <label>Document</label>
                    <input type="file">
                    <br>
                    <label style="vertical-align: top;">Description</label>
                    <textarea id="desp" rows="2" cols="35" style="margin-top: 2%;"
                              placeholder="This document is about..."></textarea>
                    <br>
                    <label>Topic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <select style="margin-top: 1%;">
                        <option>Topic 1</option>
                        <option>Topic 2</option>
                        <option>Topic 3</option>
                    </select>
                    <br>
                    <input class="form_btn" type="submit" value="Share">
                </form>
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
                <form>
                    <label>Link&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="link">
                    <br>
                    <label style="vertical-align: top;">Description</label>
                    <textarea id="desp" rows="2" cols="35" style="margin-top: 2%;"
                              placeholder="This link is about..."></textarea>
                    <br>
                    <label>Topic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <select style="margin-top: 1%;">
                        <option>Topic 1</option>
                        <option>Topic 2</option>
                        <option>Topic 3</option>
                    </select>
                    <br>
                    <input class="form_btn" type="submit" value="Share">
                </form>
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
                <form>
                    <label>Email&nbsp;&nbsp;&nbsp;</label>
                    <input type="email">
                    <br>
                    <label>Topic&nbsp;&nbsp;&nbsp;</label>
                    <select style="margin-top: 1%;">
                        <option>Topic 1</option>
                        <option>Topic 2</option>
                        <option>Topic 3</option>
                    </select>
                    <br>
                    <input class="form_btn" type="submit" value="Invite">
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>