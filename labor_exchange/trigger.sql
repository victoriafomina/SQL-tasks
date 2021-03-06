USE [labor_exchange]
GO
/****** Object:  Trigger [dbo].[employedRemoveApplications]    Script Date: 10.06.2020 17:20:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[employedRemoveApplications] ON [dbo].[person_vacancy_bindings]
FOR DELETE AS
    DELETE FROM person_vacancy_bindings WHERE person_vacancy_bindings.id_person = (SELECT id_person FROM deleted);