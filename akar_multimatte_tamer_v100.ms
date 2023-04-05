global mmtForm
(
	
	if mmtForm != undefined do mmtForm.close()
	
	pointClass = dotNetClass "System.Drawing.Point"
	sizeClass = dotNetClass "System.Drawing.Size"
	colorClass = (dotNetClass "System.Drawing.Color").fromARGB
	flatClass = (dotNetClass "System.Windows.Forms.FlatStyle").Flat
	centerClass = (dotNetClass "System.Windows.Forms.FormStartPosition").CenterScreen
	
	colorRed = colorClass 135 100 100
	colorGreen = colorClass 100 135 100
	colorBlue = colorClass 100 100 135
	colorDefault = colorClass 100 100 100
	colorBorder = colorClass 85 85 85
	colorBorderUsed = colorClass 255 255 255
	colorText = colorClass 185 185 185
	colorMouseOver = colorClass 56 56 56
	
	mmtForm = dotNetObject "maxCustomControls.MaxForm"
	mmtForm.Text = "akar \\\\ MultiMatte Tamer v1.0"
	mmtForm.Size = dotNetObject sizeClass 826 600
	mmtForm.MinimumSize = dotNetObject sizeClass 562 260
	mmtForm.StartPosition = centerClass
	mmtForm.autoScroll = false
	mmtForm.BackColor = colorClass 81 81 81
	
	collectCheckBox = dotNetObject "CheckBox"
	collectCheckBox.Location = dotNetObject pointClass 238 14
	collectCheckBox.Size = dotNetObject sizeClass 85 26
	collectCheckBox.ForeColor = colorText
	collectCheckBox.checked = false
	collectCheckBox.Text = "Collect"
	mmtForm.Controls.Add collectCheckBox
	
	selectedCheckBox = dotNetObject "CheckBox"
	selectedCheckBox.Location = dotNetObject pointClass 326 14
	selectedCheckBox.Size = dotNetObject sizeClass 100 26
	selectedCheckBox.ForeColor = colorText
	selectedCheckBox.checked = false
	selectedCheckBox.Text = "Selected"
	mmtForm.Controls.Add selectedCheckBox
	
	flowPanel = dotnetobject "FlowLayoutPanel"
	flowPanel.Location = dotNetObject pointClass 6 49
	flowPanel.Size = dotNetObject sizeClass 792 0
	flowPanel.Anchor = dotNet.CombineEnums flowPanel.Anchor.Top flowPanel.Anchor.Left flowPanel.Anchor.Right
	flowPanel.BackColor = colorClass 68 68 68
	flowPanel.AutoSize = true
	mmtForm.Controls.Add flowPanel
	
	addButton = dotNetObject "Button"
	addButton.Location = dotNetObject pointClass 8 8
	addButton.Size = dotNetObject sizeClass 106 35
	addButton.BackColor = colorDefault
	addButton.ForeColor = colorText
	addButton.FlatStyle = flatClass
	addButton.FlatAppearance.MouseOverBackColor = colorMouseOver
	addButton.FlatAppearance.BorderColor = colorBorder
	addButton.FlatAppearance.BorderSize = 1
	addButton.Text = "Add Button"
	mmtForm.Controls.Add addButton

	refreshButton = dotNetObject "Button"
	refreshButton.Location = dotNetObject pointClass 118 8
	refreshButton.Size = dotNetObject sizeClass 106 35
	refreshButton.BackColor = colorDefault
	refreshButton.ForeColor = colorText
	refreshButton.FlatStyle = flatClass
	refreshButton.FlatAppearance.MouseOverBackColor = colorMouseOver
	refreshButton.FlatAppearance.BorderColor = colorBorder
	refreshButton.FlatAppearance.BorderSize = 1
	refreshButton.Text = "Refresh"
	mmtForm.Controls.Add refreshButton
	
	elementButton = dotNetObject "Button"
	elementButton.Location = dotNetObject pointClass 690 8
	elementButton.Size = dotNetObject sizeClass 106 35
	elementButton.Anchor = dotNet.CombineEnums elementButton.Anchor.Top elementButton.Anchor.Right
	elementButton.BackColor = colorDefault
	elementButton.ForeColor = colorText
	elementButton.FlatStyle = flatClass
	elementButton.FlatAppearance.MouseOverBackColor = colorMouseOver
	elementButton.FlatAppearance.BorderColor = colorBorder
	elementButton.FlatAppearance.BorderSize = 1
	elementButton.Text = "Elements"
	mmtForm.Controls.Add elementButton
	
	-- this panel is purely visual to not have a black datagridview border
	borderPanel = dotnetobject "Panel"
	borderPanel.Location = dotNetObject pointClass 8 94
	borderPanel.Size = dotNetObject sizeClass 788 400
	borderPanel.Anchor = dotNet.CombineEnums borderPanel.Anchor.Top dataGrid.Anchor.Bottom borderPanel.Anchor.Left borderPanel.Anchor.Right
	borderPanel.Padding = dotNetObject "System.Windows.Forms.Padding" 1
	borderPanel.BackColor = colorBorder
	mmtForm.Controls.Add borderPanel
	
	dataGrid = dotNetObject "DataGridView"
	dataGrid.Location = dotNetObject pointClass 8 94
	dataGrid.Size = dotNetObject sizeClass 788 400
	dataGrid.BorderStyle = dataGrid.BorderStyle.None
	dataGrid.Dock = dataGrid.Dock.Fill
	dataGrid.RowHeadersVisible = false
	dataGrid.AutoSizeColumnsMode = dataGrid.AutoSizeColumnsMode.Fill
	dataGrid.AllowUserToResizeRows = false
	dataGrid.AllowUserToResizeColumns = true
	dataGrid.AllowUserToOrderColumns = false -- sort is lost since the grid is refilled on every event
	dataGrid.AllowUserToAddRows = false
	dataGrid.ColumnHeadersHeight = 34
	dataGrid.ColumnHeadersHeightSizeMode = dataGrid.ColumnHeadersHeightSizeMode.DisableResizing
	dataGrid.BackgroundColor = colorClass 255 255 255
	dataGrid.ForeColor = colorClass 0 0 0
	dataGrid.AlternatingRowsDefaultCellStyle.BackColor = colorClass 235 235 235
	dataGrid.DefaultCellStyle.SelectionBackColor = colorClass 130 130 130
	dataGrid.AlternatingRowsDefaultCellStyle.SelectionBackColor = colorClass 120 120 120
	dataGrid.ShowEditingIcon = false
	dataGrid.ReadOnly = true
	dataGrid.SelectionMode = dataGrid.SelectionMode.FullRowSelect
	
	columnNames = #("Name", "Layer", "OID")
	
	for Names in columnNames do (
		
		Column = dotNetObject "DataGridViewTextBoxColumn"
		Column.HeaderText = Names
		Column.SortMode = Column.SortMode.NotSortable
		
		if Names == "OID" do (
			
			Column.ValueType = dotNetClass "System.Single"
			Column.AutoSizeMode = Column.AutoSizeMode.None
			Column.Width = 50
			
		)
		
		dataGrid.Columns.Add Column
		
	)

	borderPanel.Controls.Add dataGrid 
	
	
	--select objects and renderable shapes
	fn getSelection = (
		
		choiceSelection = objects
		if selectedCheckBox.checked == true then (
			
			choiceSelection = selection
		
		)
		
		objectSelection = for o in choiceSelection 	where ((superclassof o == shape \
																		and o.render_renderable == true) \
																		or superclassof o == GeometryClass \
																		and classof o != Targetobject \
																		and o.ishidden != true \
																		) collect o
		
		objectSelection
		
	)

	
	fn checkUsed value = (
		
		result = false
		for i in getSelection() do (
			
			if i.gbufferChannel == value do (
				
				result = true
				exit
				
			)
		)
		
		result
		
	)
	
	
	fn colorButton value = (
		
		if value == 0 then (
			
			colorDefault
			
		) else if int(mod value 3) == 0 then (
			
			colorBlue
			
		) else if int(mod (value + 1) 3) == 0 then (
			
			colorGreen
			
		) else (
			
			colorRed
			
		)
	)
	
	
	fn refreshGrid = (
		
		-- collecting selected index numbers
		selectedRows = #()
		for i = 0 to (dataGrid.SelectedRows.Count - 1) do (
			
			append selectedRows dataGrid.SelectedRows.Item[i].Index
			
		)
		
		
		dataGrid.Rows.Clear()
		
		
		for i in getSelection() do (
			
			Row = dotNetObject "DataGridViewRow"
			dataGrid.Rows.Add Row
			
			Row.Cells.Item[0].Value = i.Name
			Row.Cells.Item[1].Value = i.Layer.Name
			Row.Cells.Item[2].Value = i.gbufferChannel
			
		)
		
		-- safety IF, if 'selected' changed the grid items.
		if (amax selectedRows) != undefined and (amax selectedRows) < dataGrid.Rows.Count do (
			
			dataGrid.Rows.Item[0].selected = false
			
			for index in selectedRows do (
				
				dataGrid.Rows.Item[index].Selected = true
				
			)
		)
	)
		
		
	fn gridColor value = (
		
		index = (dataGrid.Rows.Item[value].Index)
		
		grabColor = dataGrid.Rows.Item[index].Cells.Item[2].Value
		
		tempColor = flowPanel.Controls.Item[grabColor].BackColor
		
		dataGrid.Rows.Item[index].Cells.Item[2].Style.SelectionForeColor = colorClass 0 0 0
		dataGrid.Rows.Item[index].Cells.Item[2].Style.SelectionForeColor = colorClass 255 255 255
		
		if tempColor.R == 135 then (
			
			if int(mod value 2) == 0 then (
				
				dataGrid.Rows.Item[index].Cells.Item[2].Style.BackColor = colorClass 255 225 225
				dataGrid.Rows.Item[index].Cells.Item[2].Style.SelectionBackColor = colorClass 180 125 125
			
			) else (
			
				dataGrid.Rows.Item[index].Cells.Item[2].Style.BackColor = colorClass 245 215  215
				dataGrid.Rows.Item[index].Cells.Item[2].Style.SelectionBackColor = colorClass 180 125 125
-- 				dataGrid.Rows.Item[index].Cells.Item[2].Style.SelectionBackColor = colorClass 170 115 115
				
			)
			
		) else if tempColor.G == 135 then (
			
			if int(mod value 2) == 0 then (
				
				dataGrid.Rows.Item[index].Cells.Item[2].Style.BackColor = colorClass 225 255 225
				dataGrid.Rows.Item[index].Cells.Item[2].Style.SelectionBackColor = colorClass 125 180 125
			
			) else (
			
				dataGrid.Rows.Item[index].Cells.Item[2].Style.BackColor = colorClass 215 245 215
				dataGrid.Rows.Item[index].Cells.Item[2].Style.SelectionBackColor = colorClass 125 180 125
-- 				dataGrid.Rows.Item[index].Cells.Item[2].Style.SelectionBackColor = colorClass 115 170 115
				
			)
			
		) else if tempColor.B == 135 then (
			
			if int(mod value 2) == 0 then (
				
				dataGrid.Rows.Item[index].Cells.Item[2].Style.BackColor = colorClass 225 225 255
				dataGrid.Rows.Item[index].Cells.Item[2].Style.SelectionBackColor = colorClass 125 125 180
			
			) else (
			
				dataGrid.Rows.Item[index].Cells.Item[2].Style.BackColor = colorClass 215 215 245
				dataGrid.Rows.Item[index].Cells.Item[2].Style.SelectionBackColor = colorClass 125 125 180
-- 				dataGrid.Rows.Item[index].Cells.Item[2].Style.SelectionBackColor = colorClass 115 115 170
				
			)
			
		) else (
			
			if int(mod value 2) == 0 then (
				
				dataGrid.Rows.Item[index].Cells.Item[2].Style.BackColor = colorClass 255 255 255
				dataGrid.Rows.Item[index].Cells.Item[2].Style.SelectionBackColor = colorClass 130 130 130
			
			) else (
			
				dataGrid.Rows.Item[index].Cells.Item[2].Style.BackColor = colorClass 235 235 235
				dataGrid.Rows.Item[index].Cells.Item[2].Style.SelectionBackColor = colorClass 120 120 120
				
			)
		)
	)
	
	fn colorizeButtons = (
		
		refreshGrid()
		
		if collectCheckBox.checked == false then (
			
			colorArray = #(	colorRed, colorGreen, colorBlue )
			flowCount = flowPanel.Controls.Count
			
			-- 0 is skipped in the loop and needs to be set separately
			if checkUsed 0 == true then (
				
				flowPanel.Controls.Item[0].FlatAppearance.BorderColor = colorBorderUsed
				
			) else (
				
				flowPanel.Controls.Item[0].FlatAppearance.BorderColor = colorBorder
				
			)
			
			for i = 1 to (flowCount - 1) by 3 do (
				
				for col in colorArray do (
					
					flowPanel.Controls.Item[i].BackColor = col
					
					if checkUsed(i) == true then (
					
						flowPanel.Controls.Item[i].FlatAppearance.BorderColor = colorBorderUsed
						
					) else (
						
						flowPanel.Controls.Item[i].FlatAppearance.BorderColor = colorBorder
						
					)
					
					-- avoid overshooting the loop
					if i < (flowCount - 1) then (
						
						i += 1
						
					) else (
						
						exit
						
					)
				)
			)
		) else (
			
			usedCounter = 0
			-- avoid having the first id after 0 not to be checked as 0 in selection mode
			if checkUsed 0 == false do (
				
				usedCounter = 1

			)
			
			for i = 0 to (flowPanel.Controls.Count - 1) do (
				
				if checkUsed(i) == true then (
					
					flowPanel.Controls.Item[i].FlatAppearance.BorderColor = colorBorderUsed
					flowPanel.Controls.Item[i].BackColor = colorButton usedCounter
					usedCounter += 1 

				) else (
					
					flowPanel.Controls.Item[i].FlatAppearance.BorderColor = colorBorder
					flowPanel.Controls.Item[i].BackColor = colorDefault
					
				)
			)
		)
		
		for i = 0 to (dataGrid.rows.count - 1) do (
			
			gridColor i
			
		)
	)

	
	fn resizeEvent Sender Args = (

		mmtForm.MinimumSize = dotNetObject sizeClass 562 (dataGrid.Location.Y + 350)
		borderPanel.Height = (mmtForm.Height - flowPanel.Size.Height - 119)
		borderPanel.Location = dotNetObject pointClass 8 (flowPanel.Size.Height + 55)
		
	)
	

	fn checkButton sender args = (
		
		for i = 0 to dataGrid.SelectedRows.count - 1 do (
			
			index = (dataGrid.SelectedRows.Item[i].Index)
			
			(getNodeByName dataGrid.Rows.Item[index].Cells.Item[0].Value).gbufferChannel = sender.Name as integer
			dataGrid.Rows.Item[index].Cells.Item[2].Value = sender.Name
			
		)
		
		colorizeButtons()
		
	)
	
	
	fn findHighest = (
		
		value = 0
		for i in getSelection() do (
			
			if i.gbufferChannel > value do (
				
				value = i.gbufferChannel
				
			)
		)
		
		if value < 9 do (
			
			value = 9
			
		)
		
		value
		
	)


	fn createButton value = (
		
		colorize = false
		if value == unsupplied do (
			
			value = flowPanel.Controls.Count
			colorize = true
			
		)
		
		newButton = dotNetObject "Button"
		newButton.BackColor = colorDefault
		newButton.FlatAppearance.BorderColor = colorBorder
		newButton.BackColor = colorDefault
		newButton.Size = dotNetObject sizeClass 40 35
		newButton.ForeColor = colorBorderUsed
		newButton.FlatStyle = flatClass
		newButton.FlatAppearance.MouseOverBackColor = colorMouseOver
		newButton.FlatAppearance.BorderSize = 2
		newButton.Margin = dotNetObject "System.Windows.Forms.Padding" 2
		newButton.Padding = dotNetObject "System.Windows.Forms.Padding" 0
		newButton.Text = (value as string)
		newButton.Name = (value as string)
		flowPanel.Controls.Add newButton
		dotNet.AddEventHandler newButton "Click" checkButton
		dotNet.SetLifeTimeControl newButton #dotNet
		
		
		if colorize == true do (
			
			colorizeButtons()
			
		)
		
		mmtForm.MinimumSize = dotNetObject sizeClass 562 (dataGrid.Location.Y + 350)
		borderPanel.Height = (mmtForm.Height - flowPanel.Size.Height - 119)
		borderPanel.Location = dotNetObject pointClass 8 (flowPanel.Size.Height + 55)
		
	)
	
	fn checkSelect = (
		
		dataGrid.ClearSelection()
		
		colorizeButtons()
		
	)
	
	
	fn refreshAll = (
		
		dataGrid.ClearSelection()
		
		-- check if a new higher ID has been created
		currentOID = flowPanel.Controls.Count
		highestOID = findHighest()
		
		if currentOID == highestOID then (
			
			createButton highestOID
			
		) else if currentOID < highestOID do (
			
			for i = currentOID to highestOID do (
				
				createButton i
				
			)
		)
		
		colorizeButtons()
		
	)
	
	
	fn createElements = (
		
		re = maxOps.GetCurRenderElementMgr()

		-- remove all multimatte elements that include the name OID
		if (re.NumRenderElements()) != 0 do (
			
			for value in (re.NumRenderElements() - 1) to 0 by -1 do (
				
				element = re.GetRenderElement value
				
				if classof element == MultiMatteElement and matchpattern element.ElementName pattern:"*OID*" do (
					
					re.RemoveRenderElement element
					
				)
			)
		)
		
		
		elementArray = #()
		for i = 1 to (flowPanel.Controls.Count - 1) do (
			
			if flowPanel.Controls.Item[i].FlatAppearance.BorderColor.R == 255 do (
			
				append elementArray (flowPanel.Controls.Item[i].Name as integer)
			
			)
		)
		
		
		if collectCheckBox.checked == false then (
			
			for id in elementArray do (
				
				if int(mod id 3) == 0 then (
					
					if (re.NumRenderElements()) == 0 then (
						
						re.addRenderElement (MultiMatteElement elementname:("OID" + ((id / 3) as string)))
							
						element = re.GetRenderElement (re.NumRenderElements() - 1)
						
					) else (
							
						element = re.GetRenderElement (re.NumRenderElements() - 1)
						if element.ElementName != ("OID" + ((id / 3) as string)) then (
							
							re.addRenderElement (MultiMatteElement elementname:("OID" + ((id / 3) as string)))
							element = re.GetRenderElement (re.NumRenderElements() - 1)
								
						)
					)
					
					element.B_gbufID = id
					
					
					-- disable R and G if they are not present
					if finditem elementArray (id - 1) == 0 do (
-- 					if flowPanel.Controls.Item[id - 1].FlatAppearance.BorderColor.R == 255 do (
						
						element.G_gbufID = 0
						element.G_gbufIDOn = false
						
					)
					
					if finditem elementArray (id - 2) == 0 do (
-- 					if flowPanel.Controls.Item[id - 2].FlatAppearance.BorderColor.R == 255 do (
						
						element.R_gbufID = 0
						element.R_gbufIDOn = false
						
					)
				
				) else if int(mod (id + 1) 3) == 0 then (
					
					if (re.NumRenderElements()) == 0 then (
						
						re.addRenderElement (MultiMatteElement elementname:("OID" + (((id + 1) / 3) as string)))
						element = re.GetRenderElement (re.NumRenderElements() - 1)
						
					) else (
							
						element = re.GetRenderElement (re.NumRenderElements() - 1)
						if element.ElementName != ("OID" + (((id + 1) / 3) as string)) then (
							
							re.addRenderElement (MultiMatteElement elementname:("OID" + (((id + 1) / 3) as string)))
							element = re.GetRenderElement (re.NumRenderElements() - 1)
								
						)
					)
					
					element.G_gbufID = id
					
					-- disable R and B if they are not present
-- 					if flowPanel.Controls.Item[id - 1].FlatAppearance.BorderColor.R == 255 do (
					if finditem elementArray (id - 1) == 0 do (
						
						element.R_gbufID = 0
						element.R_gbufIDOn = false
						
					)
					
-- 					if flowPanel.Controls.Item[id + 1].FlatAppearance.BorderColor.R == 255 do (
					if finditem elementArray (id + 1) == 0 do (
						
						element.B_gbufID = 0
						element.B_gbufIDOn = false
						
					)
					
				) else (
					
					if (re.NumRenderElements()) == 0 then (
						
						re.addRenderElement (MultiMatteElement elementname:("OID" + (((id + 2) / 3) as string)))
						element = re.GetRenderElement (re.NumRenderElements() - 1)
						
					) else (
							
						element = re.GetRenderElement (re.NumRenderElements() - 1)
						if element.ElementName != ("OID" + (((id + 2) / 3) as string)) then (
							
							re.addRenderElement (MultiMatteElement elementname:("OID" + (((id + 2) / 3) as string)))
							element = re.GetRenderElement (re.NumRenderElements() - 1)
								
						)
					)
					
					element.R_gbufID = id
					
					-- disable G and B if they are not present
-- 					if flowPanel.Controls.Item[id + 1].FlatAppearance.BorderColor.R == 255 do (
					if finditem elementArray (id + 1) == 0 do (
						
						element.G_gbufID = 0
						element.G_gbufIDOn = false
						
					)
					
-- 					if flowPanel.Controls.Item[id + 2].FlatAppearance.BorderColor.R == 255 do (
					if finditem elementArray (id + 2) == 0 do (
						
						element.B_gbufID = 0
						element.B_gbufIDOn = false
						
					)
				)
			) 
		) else (
			
			mmeName = 1
			
			for i = 1 to elementArray.Count by 3 do (
				
				re.addRenderElement (MultiMatteElement ElementName:("OID" + (mmeName as string)))
				element = re.GetRenderElement (re.NumRenderElements() - 1)
				
				-- R
				element.R_gbufID = elementArray[i]
				
				-- G
				if i + 1 <= elementArray.Count then (
				
					element.G_gbufID = elementArray[i + 1]
					
				) else (
					
					element.G_gbufID = 0
					element.G_gbufIDOn = false
					
				)
				
				-- B
				if i + 2 <= elementArray.Count then (
				
					element.B_gbufID = elementArray[i + 2]
					
				) else (
					
					element.B_gbufID = 0
					element.B_gbufIDOn = false
					
				)

				
				if i < elementArray.Count then (
					
					mmeName += 1
					
				) else (
					
					exit
					
				)
			)
		)
	)

	dotNet.AddEventHandler collectCheckBox #CheckStateChanged colorizeButtons
	dotNet.AddEventHandler selectedCheckBox #CheckStateChanged checkSelect
	dotNet.AddEventHandler mmtForm #Resize resizeEvent
	dotNet.AddEventHandler addButton "Click" (fn none = createButton unsupplied)
	dotNet.AddEventHandler refreshButton "Click" refreshAll
	dotNet.AddEventHandler elementButton "Click" createElements
	
	-- avoid that events get garbage collected and lose reference to the script values
	dotNet.SetLifeTimeControl collectCheckBox #dotNet
	dotNet.SetLifeTimeControl selectedCheckBox #dotNet
	dotNet.SetLifeTimeControl mmtForm #dotNet
	dotNet.SetLifeTimeControl addButton #dotNet
	dotNet.SetLifeTimeControl refreshButton #dotNet
	dotNet.SetLifeTimeControl elementButton #dotNet
	
	--add first buttons
	for i = 0 to findHighest() do (
		
		createButton i
		
	)
	
	colorizeButtons()
	
	--release first button focus inside flowpanel on loading. purely visual!
	flowPanel.Focus()
	
	
	mmtForm.showModeless()
	
)





































