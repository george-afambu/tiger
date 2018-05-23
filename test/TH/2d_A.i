[Mesh]
  type = GeneratedMesh
  dim = 2
  xmin = -1
  xmax = 1
  ymin = -1
  ymax = 1
  nx = 20
  ny = 20
[]

[Modules]
  [./FluidProperties]
    [./water_uo]
      type = SimpleFluidProperties
    [../]
  [../]
[]

[Materials]
  [./advect_th]
    type = TigerUncoupledThermalMaterialTH
    fp_UO = water_uo
    user_velocity = vel
    porosity = 1.0
    conductivity_type = isotropic
    lambda = 0
    density = 0
    specific_heat = 0
    output_Pe_Cr_numbers = true
    has_supg = true
    supg_eff_length = min
    supg_coeficient = transient_tezduyar
  [../]
[]

[BCs]
  [./whole_t]
    type = DirichletBC
    variable = temperature
    boundary = 'left right top bottom'
    value = 0
  [../]
[]

[Functions]
  [./vel]
    type = ParsedVectorFunction
    value_x = '-sqrt(x*x+y*y)*sin(atan(y/x))'
    value_y = 'sqrt(x*x+y*y)*cos(atan(y/x))'
  [../]
  [./temp]
    type = ParsedFunction
    value = 'if(sqrt((x+0.5)*(x+0.5)+y*y)<0.25,0.5*(cos(4*3.14*sqrt((x+0.5)*(x+0.5)+y*y))+1),0.0)'
  [../]
[]

[ICs]
  [./init_t]
    type = FunctionIC
    function = temp
    variable = temperature
  [../]
[]

[AuxVariables]
  [./vx]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./vy]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./pe]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./cr]
    family = MONOMIAL
    order = CONSTANT
  [../]
[]

[AuxKernels]
  [./vx_ker]
    type = MaterialRealVectorValueAux
    property = 'darcy_velocity'
    variable = vx
    component = 0
  [../]
  [./vy_ker]
    type = MaterialRealVectorValueAux
    property = 'darcy_velocity'
    variable = vy
    component = 1
  [../]
  [./pe_ker]
    type = MaterialRealAux
    property = 'peclet_number'
    variable = pe
  [../]
  [./cr_ker]
    type = MaterialRealAux
    property = 'courant_number'
    variable = cr
  [../]
[]

[Variables]
  [./temperature]
  [../]
[]

[Kernels]
  [./T_advect]
    type = TigerAdvectionKernelTH
    variable = temperature
  [../]
  [./T_diff]
    type = TigerTimeDerivativeT
    variable = temperature
  [../]
[]

[Executioner]
  type = Transient
  dt = 3.14e-2
  end_time = 3.14
  solve_type = NEWTON
  [./TimeIntegrator]
     type = CrankNicolson
  [../]
  petsc_options_iname = '-ksp_type -pc_type -snes_atol -snes_rtol -snes_max_it -ksp_max_it -sub_pc_type -sub_pc_factor_shift_type'
  petsc_options_value = 'gmres asm 1E-10 1E-10 200 500 lu NONZERO'
[]

[Outputs]
  exodus = true
  print_linear_residuals = false
  interval = 10
[]
