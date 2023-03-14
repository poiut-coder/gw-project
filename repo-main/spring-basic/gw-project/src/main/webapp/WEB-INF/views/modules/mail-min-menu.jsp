<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <div class="col-md-3">
          <a href="/gw-project/mail/mail-write.action" class="btn btn-primary btn-block mb-3">메일쓰기</a>

          <div class="card">
            <div class="card-header">
              <h3 class="card-title">메뉴</h3>

              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                  <i class="fas fa-minus"></i>
                </button>
              </div>
            </div>
            <div class="card-body p-0">
              <ul class="nav nav-pills flex-column">
                                <li class="nav-item">
                  <a href="/gw-project/mail/mail-list.action" class="nav-link">
                    <i class="far fa-envelope"></i> 전체메일함
                  </a>
                </li>
                <li class="nav-item active">
                  <a href="/gw-project/mail/mail-received-list.action" class="nav-link">
                    <i class="fas fa-inbox"></i> 받은메일함
                    <span class="badge bg-primary float-right"></span>
                  </a>
                </li>
                <li class="nav-item active">
                  <a href="/gw-project/mail/mail-send-list.action" class="nav-link">
                    <i class="fas fa-inbox"></i> 보낸메일함
                  </a>
                </li>
                <li class="nav-item">
                  <a href="/gw-project/mail/mail-draft-list.action" class="nav-link">
                    <i class="far fa-file-alt"></i> 임시보관함
                  </a>
                </li>
                <li class="nav-item">
                  <a href="/gw-project/mail/mail-my-list.action" class="nav-link">
                    <i class="far fa-file-alt"></i> 내게쓴메일함
                  </a>
                </li>
                <li class="nav-item">
                  <a href="/gw-project/mail/mail-deleted.action" class="nav-link">
                    <i class="far fa-trash-alt"></i> 휴지통
                  </a>
                </li>
              </ul>
            </div>
            <!-- /.card-body -->
          
          <!-- /.card -->
          
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>