//
//  AddMeasuringSystemViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 15.04.2023.
//

import Foundation

enum MeasuringSystemError: Error {

    case emptyName
    case longName
    case emptyRatio
    case ratioNotDouble

}

class AddMeasuringSystemViewModel: ObservableObject  {

    @Published var nameMSMainTextFildViewModel: MainTextFildViewModel = MainTextFildViewModel(placeHolder: "Введите наименование")
    @Published var ratioMSMainTextFildViewModel: MainTextFildViewModel = MainTextFildViewModel(placeHolder: "Введите соотношение")
    @Published var measuringSystem: MeasuringSystem?
    @Published var addMeasuringSystemPickerViewModel: AddMeasuringSystemPickerViewModel = AddMeasuringSystemPickerViewModel()
    var textEnterЕheRatio: String {
        addMeasuringSystemPickerViewModel.typeMeasuringSystemPicker.isWeight ? "Сколько грамм" : "Сколько миллилитров"
    }
    var errorMasege: String {
        do {
            try checkMeasuringSystem()
        } catch MeasuringSystemError.emptyName {
            return "Поле название единицы измерения пустое!"
        } catch MeasuringSystemError.emptyRatio {
            return "Поле соотношение пустое!"
        } catch MeasuringSystemError.ratioNotDouble {
            return "Соотношение должно быть числом!"
        } catch MeasuringSystemError.longName {
            return "Название единицы измерения слишком длинное (до 7 букв)"
        } catch {
            return "Что то пошло не так."
        }
        return ""
    }

    func addMeasuringSystem(viewModel: CalculatorViewModel) {
        guard let measuringSystemsRatio = Double(ratioMSMainTextFildViewModel.bindingProperty) else { return }
        viewModel.savingObject(object: MeasuringSystem(name: nameMSMainTextFildViewModel.bindingProperty,
                                                       isWeight: addMeasuringSystemPickerViewModel.typeMeasuringSystemPicker.isWeight,
                                                       ratio: measuringSystemsRatio))
    }

    func checkMeasuringSystem() throws {
        guard !nameMSMainTextFildViewModel.bindingProperty.isEmpty else { throw MeasuringSystemError.emptyName }
        guard nameMSMainTextFildViewModel.bindingProperty.count <= 7 else { throw MeasuringSystemError.longName }
        guard !ratioMSMainTextFildViewModel.bindingProperty.isEmpty else { throw MeasuringSystemError.emptyRatio }
        guard let _ = Double(ratioMSMainTextFildViewModel.bindingProperty) else { throw MeasuringSystemError.ratioNotDouble }
    }

}

extension AddMeasuringSystemViewModel {

    func getData(viewModel: CalculatorViewModel) {
        measuringSystem = viewModel.secondMeasuringPickerViewModel.measuringSystemPicker
        guard let measuringSystem = measuringSystem else { return }
        nameMSMainTextFildViewModel.setupProperty(measuringSystem.name)
        ratioMSMainTextFildViewModel.setupProperty("\(measuringSystem.ratio)")
        addMeasuringSystemPickerViewModel.setupPicker(typeMeasuringSystemPicker: addMeasuringSystemPickerViewModel.typeMeasuringSystem[measuringSystem.isWeight ? 0 : 1])
    }

    func updateMeasuringSystem(viewModel: CalculatorViewModel) {
        guard let measuringSystemsRatio = Double(ratioMSMainTextFildViewModel.bindingProperty) else { return }
        guard let measuringSystem = measuringSystem else { return }
        viewModel.updateObject(oldObject: measuringSystem,
                               newObject: MeasuringSystem(name: nameMSMainTextFildViewModel.bindingProperty,
                                                          isWeight: addMeasuringSystemPickerViewModel.typeMeasuringSystemPicker.isWeight,
                                                          ratio: measuringSystemsRatio))
    }

    func deleteMeasuringSystem(viewModel: CalculatorViewModel) {
        guard let measuringSystem = measuringSystem else { return }
        viewModel.deleteObject(object: measuringSystem)
        viewModel.firstMeasuringPickerViewModel.setupPicker(measuringSystemPicker: RealmService.shared.getMeasuringSystem()[0])
        viewModel.secondMeasuringPickerViewModel.setupPicker(measuringSystemPicker: RealmService.shared.getMeasuringSystem()[0])
    }

}


