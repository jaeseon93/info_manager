<%@ tag language="java" pageEncoding="UTF-8"  %>
<%@ taglib prefix="ct" tagdir="/WEB-INF/tags" %>
<div class="modal fade " id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title" id="modal_head">#modal_head</h4>
                <button type="button" class="close" data-dismiss="modal" id="btn_modal_close">X</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body" id="div_modal_body">
                <ct:spinner />
            </div>
            <!-- Modal footer -->
            <div class="modal-footer" >
                <button type="button" class="btn btn-danger"
                        id="btn_modal_left">#btn_modal_left</button>
                <button type="button" class="btn btn-danger"
                        data-dismiss="modal" id="btn_modal_right">#btn_modal_right</button>
            </div>
        </div>
    </div>
</div>