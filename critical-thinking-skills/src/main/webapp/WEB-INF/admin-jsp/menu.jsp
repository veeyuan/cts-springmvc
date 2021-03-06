
  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="index3.html" class="brand-link">
      <img src="assets/img/index/idea-icon.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3"
           style="opacity: .8">
      <span class="brand-text font-weight-light">HOTS</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="assets/img/index/user-icon.png" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a id="usernameDisplay" href="#" class="d-block"></a>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav  class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          
			<li class="nav-item">
            <a id="dashboardLink" href="dashboard.html" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Dashboard
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a id="gradeLink" href="gradeRstWaitingList.html" class="nav-link">
              <i class="nav-icon fa fa-trophy"></i>
              <p>
                Grade Results
                <% 
                int waitingtogradeNum = (Integer)request.getSession().getAttribute("waitingtogradeNum");
                if (waitingtogradeNum>0){ %>  
                <span class="badge badge-info right" ><%=request.getSession().getAttribute("waitingtogradeNum").toString() %> </span>
                <%} %>
              </p>
            </a>
          </li>
          <li id="btn-managequestion" class="nav-item">
            <a id="addLink" href="addQuestion.html" class="nav-link">
               <i class="nav-icon fas fa-copy"></i>
              <p >
                Add Question
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a id="manageLink" href="manageQuestion.html" class="nav-link">
               <i class="nav-icon fas fa-edit"></i>
              <p>
                Manage Questions
              </p>
            </a>
          </li>
          
          <li class="nav-item">
            <a id="manageOptLink" href="manageOption.html" class="nav-link">
               <i class="nav-icon fa fa-tasks"></i>
              <p>
                Manage Options
              </p>
            </a>
          </li>
          <% if (request.getSession().getAttribute("rolecd").toString().equalsIgnoreCase("superadmin")){ %>
          <li class="nav-item">
            <a id="manageAdminLink" href="manageAdmin.html" class="nav-link">
               <i class="nav-icon fas fa-user-lock"></i>
              <p>
                Manage Admin
              </p>
            </a>
          </li>
          <%} %>
          <li class="nav-item">
            <a id="changePswdLink" href="changePassword.html" class="nav-link">
               <i class="nav-icon fas fa-lock"></i>
              <p>
                Change Passwords
              </p>
            </a>
          </li>
           <li class="nav-item">
            <a id="logoutLink" href="logout.html" class="nav-link">
               <i class="nav-icon fas fa-door-open"></i>
              <p>
                Logout
              </p>
            </a>
          </li>
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
  