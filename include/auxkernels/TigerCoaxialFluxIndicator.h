/**************************************************************************/
/*  TIGER - THMC sImulator for GEoscience Research                        */
/*                                                                        */
/*  Copyright (C) 2017 by Maziar Gholami Korzani                          */
/*  Karlsruhe Institute of Technology, Institute of Applied Geosciences   */
/*  Division of Geothermal Research                                       */
/*                                                                        */
/*  This file is part of TIGER App                                        */
/*                                                                        */
/*  This program is free software: you can redistribute it and/or modify  */
/*  it under the terms of the GNU General Public License as published by  */
/*  the Free Software Foundation, either version 3 of the License, or     */
/*  (at your option) any later version.                                   */
/*                                                                        */
/*  This program is distributed in the hope that it will be useful,       */
/*  but WITHOUT ANY WARRANTY; without even the implied warranty of        */
/*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          */
/*  GNU General Public License for more details.                          */
/*                                                                        */
/*  You should have received a copy of the GNU General Public License     */
/*  along with this program.  If not, see <http://www.gnu.org/licenses/>  */
/**************************************************************************/

#ifndef TIGERCOAXIALFLUXINDICATOR_H
#define TIGERCOAXIALFLUXINDICATOR_H

#include "AuxKernel.h"

class TigerCoaxialFluxIndicator;

template <>
InputParameters validParams<TigerCoaxialFluxIndicator>();

class TigerCoaxialFluxIndicator : public AuxKernel
{
public:
  TigerCoaxialFluxIndicator(const InputParameters & parameters);

protected:
  virtual Real computeValue() override;

private:
  // imported props from TigerHydarulicMaterial

  const VariableValue & _coupled_var;
  const VariableValue & _wall_var;

  // conductivity of drilling pipe
  const MaterialProperty<Real> & _kd;
  // outer radius of drilling pipe
  const MaterialProperty<Real> & _rdo;
  // inner radius of drilling pipe
  const MaterialProperty<Real> & _rdi;
  // time function
  const MaterialProperty<Real> & _fac;

};

#endif // TIGERCOAXIALFLUXINDICATOR_H